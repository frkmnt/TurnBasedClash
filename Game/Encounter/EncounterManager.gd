extends Node

#=== About ===#
# The root node of an encounter combat sequence. 


#=== Prefabs ===#
const _encounter_data_prefab = preload("res://Encounter/EncounterData.gd")

#=== Components ===#
var _map_manager 
var _character_manager 
var _modifier_generator 
var _input_parser 
var _camera 
var _ui_manager

#=== Variables ===#
var _mode = "camera" # camera, attack, skill, move, bag
var _encounter_data


#=== Bootstrap ===#

# Initialize the combat scene and load all relevant components.
func _ready():
	randomize() # TODO add seed management
	var encounter_data = initialize_generator()
	initialize_map_manager(encounter_data.get("tilemap"))
	initialize_camera()
	initialize_character_manager(encounter_data.get("party"), encounter_data.get("enemies"))
	initialize_modifier_generator()
	initialize_input_parser()
	initialize_ui_manager()
	initialize_encounter_data()
	initialize_signals()
	initialize_game()
	#TODO DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)


# Initialize the random encounter generator and all its subcomponents.
func initialize_generator():
	var generator = $EncounterGenerator
	var encounter_data = generator.generate_encounter("Test", 1, null)
	return encounter_data


# Initialize the map manager and all its subcomponents.
func initialize_map_manager(tilemap):
	_map_manager = $MapManager
	_map_manager.initialize(tilemap)


# Initialize the character manager and all its subcomponents.
func initialize_character_manager(party, enemies):
	_character_manager = $CharacterManager
	_character_manager.initialize(party, enemies)

# Initialize the character manager and all its subcomponents.
func initialize_modifier_generator():
	_modifier_generator = $ModifierGenerator
	_modifier_generator.initialize()


# Initialize the input parser and all its subcomponents.
func initialize_input_parser():
	_input_parser = $InputParser
	_input_parser.initialize()


# Initialize the Camera and all its subcomponents.
func initialize_camera():
	_camera = $EncounterCamera
	var tilemap_center = _map_manager._tilemap.calculate_center_position()
	_camera.position = tilemap_center


# Initialize the UI Manager and all its subcomponents.
func initialize_ui_manager():
	_ui_manager = $UiManager
#	_ui_manager.initialize_animation_player()


# Bind all signals to the corresponding functions.
func initialize_signals():
	SignalManager._on_game_start_announcement_finished.connect(on_game_start_announcement_finished)
	SignalManager._on_turn_announcement_finished.connect(on_turn_announcement_finished)
	SignalManager._highlight_current_character.connect(highlight_current_character)
	SignalManager._highlight_tiles.connect(highlight_tiles)
	SignalManager._remove_highlight_from_tiles.connect(remove_highlight_from_tiles)
	SignalManager._on_skill_selected.connect(on_skill_selected)
	SignalManager._on_bag_selected.connect(on_bag_selected)
	SignalManager._on_player_character_moved.connect(on_player_character_moved)
	SignalManager._on_player_character_finished_moving.connect(on_player_character_finished_moving)
	SignalManager._on_pass_turn.connect(on_turn_end)
	SignalManager._on_action_input.connect(_input_parser.parse_action_input)
	SignalManager._on_mouse_input.connect(_input_parser.parse_mouse_input)
	SignalManager._on_mouse_motion.connect(_input_parser.parse_mouse_motion)
	SignalManager._on_register_log.connect(on_register_log)
	SignalManager._update_all_input_locks.connect(update_all_input_locks)
	SignalManager._on_button_pressed.connect(on_button_pressed)


# Initialize the encounter data.
func initialize_encounter_data():
	_encounter_data = _encounter_data_prefab.new()


# After all components have loaded and initialized, start the game.
func initialize_game():
	_map_manager.place_teams(_character_manager._character_data)
	var cur_char_id = _character_manager.get_first_character_id()
	var is_ally = _character_manager.is_character_ally(cur_char_id)
	if not is_ally:
		_ui_manager.hide_speed_label()
	_ui_manager.play_game_start_announcement()


# Event triggered via signal when the game start announcement animation is finished.
func  on_game_start_announcement_finished():
	turn_start()





#=== Turn Start ===#

# Logic that applies when the turn starts. Applies different logic
# depending on whether the character is an ally or an enemy.
func turn_start():
	var cur_char_data = _character_manager.increment_turn_queue() # [cur_character_id, cur_character]
	var is_ally = _character_manager.is_character_ally(cur_char_data[0])
	_map_manager.highlight_character(cur_char_data[0], is_ally)
	_character_manager.start_turn_current_character()
	if is_ally:
		turn_start_ally(cur_char_data)
	else:
		turn_start_enemy()
	var cur_turn = _encounter_data.turn_start(is_ally) 
	_ui_manager.play_round_announcement(cur_turn)

# Logic that applies when a player character's turn starts.
func turn_start_ally(cur_char_data):
	var cur_char_coords = _map_manager.get_character_coords(cur_char_data[0])
	var cur_speed = cur_char_data[1]._stats._cur_speed
	_ui_manager.set_speed_label(cur_speed)
	_ui_manager.set_skills_on_panel(_character_manager.get_current_character_skills())
	#_ui_manager.set_bag_on_panel(_character_manager.get_current_character_bag())
	_map_manager.calculate_moveable_tiles(cur_char_coords, cur_speed)

# Logic that applies whenski an enemy character's turn starts.
func turn_start_enemy():
	_ui_manager.hide_speed_label()


# Event triggered via signal when the round start announcement animation is finished.
# If it is an enemy's turn, apply the round start effect to start the enemy's behaviour.
# TODO check the input parameters and restrict it via status 
func  on_turn_announcement_finished():
	var is_ally = _character_manager.is_current_character_ally()
	if is_ally:
		update_all_input_locks(true, true)
	else:
		update_all_input_locks(true, false)
	_character_manager.apply_turn_start()





#=== Turn End ===#

# Logic that applies when the turn ends.
func on_turn_end():
#	_mode = "camera"
	set_mode_button("camera")
	_ui_manager.set_camera_mode_no_signal()
	_map_manager.remove_all_highlights()
	update_all_input_locks(true, false)
	turn_start()





#=== Player Character ===#

# Triggered by the MapManager when a player character has moved.
func on_player_character_moved(data):
	var cur_speed = _character_manager.on_player_character_moved(data[0], data[1], data[2])
	_ui_manager.set_speed_label(cur_speed)


# Event triggered via signal when a player character has finished moving.
func on_player_character_finished_moving():
	var cur_char_id = _character_manager.get_current_character_id()
	var is_ally = _character_manager.is_character_ally(cur_char_id)
	_map_manager.highlight_character(cur_char_id, is_ally)
	var cur_speed = _character_manager.get_current_character_current_speed()
	if cur_speed > 0:
		var cur_char_coords = _map_manager.get_character_coords(cur_char_id)
		_map_manager.calculate_moveable_tiles(cur_char_coords, cur_speed)
		_map_manager.highlight_moveable_tiles()
	_character_manager.on_player_character_finished_moving(cur_char_id)





#=== Highlight Management ===#

func highlight_current_character():
	var cur_char_id = _character_manager.get_current_character_id()
	var is_ally = _character_manager.is_character_ally(cur_char_id)
	_map_manager.highlight_character(cur_char_id, is_ally)


func highlight_tiles(coords_list, color_id):
	_map_manager.create_highlight_at_coords_list(coords_list, color_id)


func remove_highlight_from_tiles(coords_list):
	_map_manager.remove_highlight_from_coords_list(coords_list)





#=== Click Management ===#

# Handles a left click input.
func handle_left_click():
	match _mode:
		"camera":
			handle_left_click_camera()
		"move":
			handle_left_click_move()
		"skill":
			handle_left_click_skill()


# Handles a left click input while in camera mode.
func handle_left_click_camera():
	_map_manager.clicked_in_camera_mode()


# Handles a left click input while in move mode.
func handle_left_click_move():
	var coords = _map_manager.validate_click_pos_to_coordinates()
	if coords == null:
		return
	var character_id = _character_manager.get_current_character_id()
	var cur_speed = _character_manager.get_current_character_current_speed()
	_map_manager.clicked_in_move_mode(coords, character_id, cur_speed)

# Handles a left click input while in move mode.
func handle_left_click_skill():
	var coords = _map_manager.validate_click_pos_to_coordinates()
	if coords == null:
		return
	var character_id = _character_manager.get_current_character_id()
	_map_manager.clicked_in_skill_mode(coords, character_id)


# Event triggered via signal. Handles a button being pressed.
func on_button_pressed(button_id):
	_input_parser.parse_action_input(button_id)





#=== Skills ===#

func on_skill_selected(skill):
	var character_id = _character_manager.get_current_character_id()
	_ui_manager.disable_skill_panel()
	_ui_manager.disable_main_button_panel()
	_ui_manager.enable_skill_button_panel()
	_map_manager.on_skill_selected(character_id, skill)


func on_skill_confirmed():
	pass

func on_skill_canceled():
	_map_manager.remove_highlight_from_targeted_tiles()
	_map_manager.remove_highlight_from_selected_tiles()
	disable_skill_mode()

#=== Bags ===#

func on_bag_selected(skill):
	var character_id = _character_manager.get_current_character_id()
	_ui_manager.disable_skill_panel()
	_ui_manager.disable_main_button_panel()
	_ui_manager.enable_skill_button_panel()
	_map_manager.on_bag_selected(character_id, skill)


func on_bag_confirmed():
	pass

func on_bag_canceled():
	_map_manager.remove_highlight_from_targeted_tiles()
	_map_manager.remove_highlight_from_selected_tiles()
	disable_bag_mode()


#=== Enable Mode ===#

# Handles a player clicking a mode button, ie. skill, move, etc.
# If a player clicks a different button than the one currently clicked, it will switch to that mode.
# Otherwise, it will switch back to camera mode.
func set_mode_button(mode_id):
	disable_current_mode()
	if _mode == mode_id:
		_mode = "camera"
	else:
		_mode = mode_id
	enable_current_mode()


func enable_current_mode():
	match _mode:
		"camera":
			enable_camera_mode()
		"move":
			enable_move_mode()
		"attack":
			enable_attack_mode()
		"skill":
			enable_skill_mode()
		"bag":
			enable_bag_mode()
		"pass":
			enable_pass_mode()
		"inspect":
			enable_inspect_mode()


# Enable the camera mode.
func enable_camera_mode():
	pass

# Enable the attack mode. Only possible during the player's turn.
func enable_attack_mode():
	if _encounter_data._is_player_round:
		_ui_manager.enable_button("attack")

# Enable the skill mode. Only possible during the player's turn.
func enable_skill_mode():
	if _encounter_data._is_player_round:
		_ui_manager.enable_button("skill")
		_ui_manager.enable_skill_panel()

# Enable the move mode. Only possible during the player's turn.
func enable_move_mode():
	if _encounter_data._is_player_round:
		_ui_manager.enable_button("move")
		_map_manager.highlight_moveable_tiles()

# Enable the bag/inventory mode. 
func enable_bag_mode():
	if _encounter_data._is_player_round:
		_ui_manager.enable_button("bag")
		_ui_manager.enable_bag_panel()

# Enable the pass mode. Only possible during the player's turn.
func enable_pass_mode():
	on_turn_end()

# Enable the inspect mode.
func enable_inspect_mode():
	_ui_manager.enable_button("inspect")





#=== Disable Mode ===#

# Disables the currently selected mode. Triggered by set_mode_button().
func disable_current_mode():
	match _mode:
		"camera":
			disable_camera_mode()
		"attack":
			disable_attack_mode()
		"skill":
			disable_skill_mode()
		"move":
			disable_move_mode()
		"bag":
			disable_bag_mode()
		"pass":
			disable_pass_mode()
		"inspect":
			disable_inspect_mode()


# Disable the camera mode.
func disable_camera_mode():
	pass

# Disable the attack mode.
func disable_attack_mode():
	_ui_manager.disable_button("attack")

# Disable the skill mode.
func disable_skill_mode():
	_ui_manager.disable_button("skill")
	_ui_manager.disable_skill_button_panel()
	_ui_manager.disable_skill_panel()
	_ui_manager.enable_main_button_panel()

# Disable the move mode.
func disable_move_mode():
	_ui_manager.disable_button("move")
	_map_manager.remove_highlight_from_moveable_tiles()
	_map_manager.clear_selected_path()

# Disable the bag/inventory mode.
func disable_bag_mode():
	_ui_manager.disable_button("bag")

# Disable the pass mode.
func disable_pass_mode():
	_ui_manager.disable_button("pass")

# Disable the inspect mode.
func disable_inspect_mode():
	_ui_manager.disable_button("inspect")





#=== UI Management ===#

# Returns true if the camera and zoom can be used.
func can_move_camera():
	var can_move = true
	if _camera._is_locked:
		can_move = false
	return can_move


# Event triggered via signal. Updates the camera and button locks' status.
func update_all_input_locks(cam_move_cam, can_use_buttons):
	_input_parser.set_can_move_camera(cam_move_cam)
	_input_parser.update_all_button_locks(can_use_buttons)


# Event triggered via signal. Registers a log to the log manager.
func on_register_log(log_data):
	_ui_manager.register_log(log_data)
