extends Node

#=== About ===#
# Handles the UI components of a combat encounter. 
# TODO this class should dinamically display the keybind in each corresponding button
# TODO disable button hover when dragging the screen

#=== Signals ===#
signal on_action_input

#=== References ===#
var _encounter_manager

#=== Components ===#
var _attack_button
var _skill_button
var _move_button
var _bag_button
var _pass_button
var _inspect_button
var _options_button
var _speed_label
var _announcement_manager


#=== Bootstrap ===#

func _ready():
	_encounter_manager = get_parent()
	_attack_button = $ButtonPanel/AttackButton
	_skill_button = $ButtonPanel/SkillButton
	_move_button = $ButtonPanel/MoveButton
	_bag_button = $ButtonPanel/BagButton
	_pass_button = $ButtonPanel/PassButton
	_inspect_button = $ButtonPanel/InspectButton
#	_options_button = $ButtonPanel/OptionsButton
	_speed_label = $SpeedLabel
	_announcement_manager = $AnnouncementManager

func initialize_announcement_manager():
	pass




#=== Buttons ===#

func on_button_pressed(button_id): # each buttons id is the same as its mode_id
	_encounter_manager._input_parser.parse_action_input(button_id) # TODO abstract to signal call ""



func handle_button_pressed_visuals(new_mode):
	var cur_mode = _encounter_manager._mode
	if cur_mode == "camera": # camera to mode
		var new_button = get_button_by_id(new_mode)
		new_button.set_pressed_no_signal(true)
	elif cur_mode == new_mode: # mode to camera
		var cur_button = get_button_by_id(cur_mode)
		cur_button.set_pressed_no_signal(false)
	else: # mode to mode
		var cur_button = get_button_by_id(cur_mode)
		cur_button.set_pressed_no_signal(false)
		var new_button = get_button_by_id(new_mode)
		new_button.set_pressed_no_signal(true)


func get_button_by_id(id):
	var button
	match id:
		"attack":
			button = _attack_button
		"skill":
			button = _skill_button
		"move":
			button = _move_button
		"bag":
			button = _bag_button
		"pass":
			button = _pass_button 
		"inspect":
			button = _inspect_button 
	return button


func set_camera_mode_no_signal():
	var cur_mode = _encounter_manager._mode
	if cur_mode != "camera":
		var cur_button = get_button_by_id(cur_mode)
		cur_button.set_pressed_no_signal(false)


#=== Announcements ===#

func play_game_start_announcement():
	_announcement_manager.emit_game_start_announcement()

func play_round_announcement(round_num):
	_announcement_manager.emit_round_announcement(round_num)




#=== Update Values ===#

func set_speed_label(new_speed):
	_speed_label.set_speed(new_speed)






