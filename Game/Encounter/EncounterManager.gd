extends Node

#=== About ===#
# The root node of an encounter combat sequence. 


#=== Prefabs ===#
const _encounter_data_prefab = preload("res://Encounter/EncounterData.gd")

#=== Components ===#
var _map_manager 
var _character_manager 
var _input_parser 
var _camera 
var _ui_manager

#=== Variables ===#
var _mode = "camera" # camera, attack, skill, move, bag
var _encounter_data


#=== Bootstrap ===#

func _ready():
	randomize() # TODO add seed management
	var encounter_data = initialize_generator()
	initialize_map_manager(encounter_data.get("tilemap"))
	initialize_camera()
	initialize_character_manager(encounter_data.get("party"), encounter_data.get("enemies"))
	initialize_input_parser()
	initialize_ui_manager()
	initialize_encounter_data()
	initialize_signals()
	initialize_game()
	_ui_manager.play_game_start_announcement()
	#TODO DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)


func initialize_generator():
	var generator = $EncounterGenerator
	var encounter_data = generator.generate_encounter("Test", 1, null)
	return encounter_data



func initialize_map_manager(tilemap):
	_map_manager = $MapManager
	_map_manager.initialize(tilemap)

func initialize_character_manager(party, enemies):
	_character_manager = $CharacterManager
	_character_manager.initialize(party, enemies)

func initialize_input_parser():
	_input_parser = $InputParser
	_input_parser.initialize()

func initialize_camera():
	_camera = $EncounterCamera
	var tilemap_center = _map_manager._tilemap.calculate_center_position()
	_camera.position = tilemap_center

func initialize_ui_manager():
	_ui_manager = $UiManager
#	_ui_manager.initialize_animation_player()

func initialize_signals():
	SignalManager._on_game_start_announcement_finished.connect(on_game_start_announcement_finished)
	SignalManager._on_round_announcement_finished.connect(on_round_announcement_finished)
	SignalManager._on_character_moved.connect(_on_character_moved)
	SignalManager._on_character_finished_moving.connect(_on_character_finished_moving)
	SignalManager._on_action_input.connect(_input_parser.parse_action_input) # TODO prefix signals with underscore
	SignalManager._on_mouse_input.connect(_input_parser.parse_mouse_input)
	SignalManager._on_mouse_motion.connect(_input_parser.parse_mouse_motion)
	

func initialize_encounter_data():
	_encounter_data = _encounter_data_prefab.new()


func initialize_game():
	_map_manager.place_teams(_character_manager._character_data)





#=== Turn Management ===#

func turn_start():
	_character_manager.turn_start()
	var cur_char_id = _character_manager.get_current_character_id()
	var cur_char_coords = _map_manager.get_character_coords(cur_char_id)
	var cur_speed = _character_manager.get_current_character_current_speed()
	_ui_manager.set_speed_label(cur_speed)
	_map_manager.calculate_moveable_tiles(cur_char_coords, cur_speed)
	var is_ally = _character_manager.is_ally_of_current_character(cur_char_id)
	_map_manager.highlight_current_character(cur_char_id, is_ally)
	var cur_turn = _encounter_data.turn_start() # TODO ^^^^^ The same as _on_character_finished_moving, extract the function
	_ui_manager.play_round_announcement(cur_turn)


func on_action_taken():
	if _character_manager.is_turn_over():
		on_turn_end()


func on_turn_end():
	_ui_manager.set_camera_mode_no_signal()
	_map_manager.remove_all_highlights()
	_input_parser.set_can_input(false)
	_mode = "camera"
	turn_start()





#=== Click Management ===#

func handle_left_click():
	match _mode:
		"camera":
			handle_left_click_camera()
		"move":
			handle_left_click_move()


func handle_left_click_camera():
	_map_manager.clicked_in_camera_mode()

func handle_left_click_move():
	var coords = _map_manager.validate_click_pos_to_coordinates()
	if coords == null:
		return
	var character_id = _character_manager.get_current_character_id()
	var cur_speed = _character_manager.get_current_character_current_speed()
	_map_manager.clicked_in_move_mode(coords, character_id, cur_speed)




#=== Signal Management ===#

func  on_game_start_announcement_finished():
	turn_start()

func  on_round_announcement_finished():
	var cur_char_id = _character_manager.get_current_character_id()
	var is_ally = _character_manager.is_ally_of_current_character(cur_char_id)
	
	_input_parser.set_can_input(true)



#=== Character ===#

func _on_character_moved(data):
	_character_manager.move_character_along_path(data[0], data[1])
	var cur_speed = _character_manager.decrease_character_current_speed(data[0], data[2])
	_ui_manager.set_speed_label(cur_speed)


func _on_character_finished_moving():
	var cur_char_id = _character_manager.get_current_character_id()
	var cur_char_coords = _map_manager.get_character_coords(cur_char_id)
	var is_ally = _character_manager.is_ally_of_current_character(cur_char_id)
	_map_manager.highlight_current_character(cur_char_id, is_ally)
	if _character_manager.is_turn_over():
		on_turn_end()
	else:
		var cur_speed = _character_manager.get_current_character_current_speed()
		_map_manager.calculate_moveable_tiles(cur_char_coords, cur_speed)
		_map_manager.highlight_moveable_tiles()



#=== Mode Management ===#

func set_mode(mode_id):
	_ui_manager.handle_button_pressed_visuals(mode_id)
	disable_current_mode()
	if _mode == mode_id:
		_mode = "camera"
	else:
		_mode = mode_id
	enable_current_mode()


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

func disable_camera_mode():
	pass

func disable_attack_mode():
	pass

func disable_skill_mode():
	pass

func disable_move_mode():
	_map_manager.remove_highlight_from_moveable_tiles()

func disable_bag_mode():
	pass

func disable_pass_mode():
	pass

func disable_inspect_mode():
	pass


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

func enable_camera_mode():
	pass

func enable_attack_mode():
	pass

func enable_skill_mode():
	pass

func enable_move_mode():
	_map_manager.highlight_moveable_tiles()

func enable_bag_mode():
	pass

func enable_pass_mode():
	on_turn_end()

func enable_inspect_mode():
	pass




