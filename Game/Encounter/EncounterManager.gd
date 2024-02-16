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
	_ui_manager.play_game_start_announcement()
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
	SignalManager._on_round_announcement_finished.connect(on_round_announcement_finished)
	SignalManager._on_character_moved.connect(on_character_moved)
	SignalManager._on_character_finished_moving.connect(on_character_finished_moving)
	SignalManager._on_pass_turn.connect(on_turn_end)
	SignalManager._on_action_input.connect(_input_parser.parse_action_input) # TODO prefix signals with underscore
	SignalManager._on_mouse_input.connect(_input_parser.parse_mouse_input)
	SignalManager._on_mouse_motion.connect(_input_parser.parse_mouse_motion)


# Initialize the encounter data.
func initialize_encounter_data():
	_encounter_data = _encounter_data_prefab.new()


# After all components have loaded and executed, start the game.
func initialize_game():
	_map_manager.place_teams(_character_manager._character_data)
	var cur_char_id = _character_manager.get_first_character_id()
	var is_ally = _character_manager.is_character_ally(cur_char_id)
	_map_manager.highlight_character(cur_char_id, is_ally)





#=== Turn Management ===#

# Logic that applies when the turn starts.
func turn_start():
	var cur_char_id = _character_manager.turn_start()
	var is_ally = _character_manager.is_character_ally(cur_char_id)
	var cur_char_coords = _map_manager.get_character_coords(cur_char_id)
	var cur_speed = _character_manager.get_current_character_current_speed()
	_ui_manager.set_speed_label(cur_speed)
	_map_manager.calculate_moveable_tiles(cur_char_coords, cur_speed)
	_map_manager.highlight_character(cur_char_id, is_ally) # TODO The same as _on_character_finished_moving, extract the function
	var cur_turn = _encounter_data.turn_start(is_ally) 
	_ui_manager.play_round_announcement(cur_turn)


# Logic that applies when the turn ends.
func on_turn_end():
	_ui_manager.set_camera_mode_no_signal()
	_map_manager.remove_all_highlights()
	_input_parser.set_can_input(false)
	_mode = "camera"
	turn_start()





#=== Click Management ===#

# Handles a left click input.
func handle_left_click():
	match _mode:
		"camera":
			handle_left_click_camera()
		"move":
			handle_left_click_move()


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




#=== Signal Management ===#

# Event triggered via signal when the game start announcement animation is finished.
func  on_game_start_announcement_finished():
	turn_start()


# Event triggered via signal when the round start announcement animation is finished.
# If it is an enemy's turn, apply the round start effect to start the enemy's behaviour.
# TODO check the input parameters and restrict it via status 
func  on_round_announcement_finished():
	_character_manager.apply_turn_start_to_current_character()
	_input_parser.set_can_input(true)




#=== Character ===#

# Triggered by the MapManager when a character has moved.
#TODO improve coupling
func on_character_moved(data):
	_character_manager.on_character_moved(data[0], data[1])
	var cur_speed = _character_manager.decrease_character_current_speed(data[0], data[2])
	_ui_manager.set_speed_label(cur_speed)


# Event triggered via signal when the a character has finished moving.
func on_character_finished_moving():
	var cur_char_id = _character_manager.get_current_character_id()
	var cur_char_coords = _map_manager.get_character_coords(cur_char_id)
	var is_ally = _character_manager.is_character_ally(cur_char_id)
	_map_manager.highlight_character(cur_char_id, is_ally)
	if _character_manager.is_turn_over():
		on_turn_end()
	else:
		var cur_speed = _character_manager.get_current_character_current_speed()
		if is_ally:
			_map_manager.calculate_moveable_tiles(cur_char_coords, cur_speed)
			_map_manager.highlight_moveable_tiles()





#=== Mode Management ===#

# Handles a player clicking a mode button.
# If a player clicks a different button than the one currently clicked, it will switch to that mode.
# Otherwise, it will switch back to camera mode.
func set_mode(mode_id):
	_ui_manager.handle_button_pressed_visuals(mode_id)
	disable_current_mode()
	if _mode == mode_id:
		_mode = "camera"
	else:
		_mode = mode_id
	enable_current_mode()


# Disables the currently selected mode. Triggered by set_mode().
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
	pass

# Disable the skill mode.
func disable_skill_mode():
	pass

# Disable the move mode.
func disable_move_mode():
	_map_manager.remove_highlight_from_moveable_tiles()

# Disable the bad/inventory mode.
func disable_bag_mode():
	pass

# Disable the pass mode.
func disable_pass_mode():
	pass

# Disable the inspect mode.
func disable_inspect_mode():
	pass


# Enables the currently selected mode. Triggered by set_mode().
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
		pass

# Enable the skill mode. Only possible during the player's turn.
func enable_skill_mode():
	if _encounter_data._is_player_round:
		pass

# Enable the move mode. Only possible during the player's turn.
func enable_move_mode():
	if _encounter_data._is_player_round:
		_map_manager.highlight_moveable_tiles()

# Enable the bad/inventory mode. 
func enable_bag_mode():
	pass

# Enable the pass mode. Only possible during the player's turn.
func enable_pass_mode():
	on_turn_end()

# Enable the inspect mode.
func enable_inspect_mode():
	pass




