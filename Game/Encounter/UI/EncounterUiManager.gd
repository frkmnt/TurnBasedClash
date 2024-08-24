extends Node

#=== About ===#
# Handles the UI components of a combat encounter.
# Each buttons' id is the same as its' mode_id in the InputManager.
# TODO this class should dinamically display the keybind in each corresponding button
# TODO disable button hover when dragging the screen

#=== Signals ===#
signal on_action_input

#=== References ===#
var _encounter_manager

#=== Components ===#
var _main_button_panel # Main Buttons
var _attack_button 
var _skill_button
var _move_button
var _bag_button
var _pass_button
var _inspect_button

var _skill_button_panel # Skill Buttons
var _confirm_skill_button
var _cancel_skill_button

var _bag_button_panel # Bag Buttons
var _confirm_bag_button
var _cancel_bag_button

#var _options_button
var _speed_label
var _announcement_manager
var _log_manager
var _skill_panel
var _bag_panel


#=== Bootstrap ===#

func _ready():
	_encounter_manager = get_parent()
	_main_button_panel = $UiContainer/MainButtonPanel
	_attack_button = $UiContainer/MainButtonPanel/AttackButton
	_skill_button = $UiContainer/MainButtonPanel/SkillButton
	_move_button = $UiContainer/MainButtonPanel1320/MoveButton
	_bag_button = $UiContainer/MainButtonPanel/BagButton
	_pass_button = $UiContainer/MainButtonPanel/PassButton
	_inspect_button = $UiContainer/MainButtonPanel/InspectButton
	
	_skill_button_panel = $UiContainer/SkillButtonPanel
	_confirm_skill_button = $UiContainer/SkillButtonPanel/ConfirmSkillButton
	_cancel_skill_button = $UiContainer/SkillButtonPanel/CancelSkillButton
	
	_bag_button_panel = $UiContainer/BagButtonPanel
	_confirm_bag_button = $UiContainer/BagButtonPanel/ConfirmBagButton
	_cancel_bag_button = $UiContainer/BagButtonPanel/CancelBagButton
	
	_speed_label = $UiContainer/SpeedLabel
	_announcement_manager = $UiContainer/AnnouncementManager
	_log_manager = $UiContainer/LogManager
	_skill_panel = $UiContainer/SkillPanel
	_bag_panel = $UiContainer/BagPanel
	
	disable_skill_button_panel()
	disable_skill_panel()
	disable_bag_button_panel()
	disable_bag_panel()





#=== Buttons ===#

## Handles a button press (on_button_up) based on the provided button_id.
## Each buttons' id is the same as its' mode_id in the InputManager.
#func on_button_pressed(button_id): 
#	_encounter_manager._input_parser.parse_action_input(button_id) # TODO abstract to signal call ""


func enable_button(button_id):
	var button = get_button_by_id(button_id)
	if button != null:
		button.set_pressed_no_signal(true)


func disable_button(button_id):
	var button = get_button_by_id(button_id)
	if button != null:
		button.set_pressed_no_signal(false)




#func handle_button_pressed_visuals(new_mode):
#	var cur_mode = _encounter_manager._mode
#	if cur_mode == "camera": # camera to mode
#		if new_mode != "camera":
#			var new_button = get_button_by_id(new_mode)
#			new_button.set_pressed_no_signal(true)
#	elif cur_mode == new_mode: # mode to camera
#		var cur_button = get_button_by_id(cur_mode)
#		cur_button.set_pressed_no_signal(false)
#	else: # mode to mode
#		var cur_button = get_button_by_id(cur_mode)
#		cur_button.set_pressed_no_signal(false)
#		var new_button = get_button_by_id(new_mode)
#		new_button.set_pressed_no_signal(true)


func get_button_by_id(id):
	var button = null
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




#=== Logs ===#

func register_log(log_data):
	_log_manager.register_log(log_data)




#=== Main Button Panel ===#

func enable_main_button_panel():
	_main_button_panel.set_process_input(true)
	_main_button_panel.visible = true
	
func disable_main_button_panel():
	_main_button_panel.set_process_input(false)
	_main_button_panel.visible = false


#=== Skill Button Panel ===#

func enable_skill_button_panel():
	_skill_button_panel.set_process_input(true)
	_skill_button_panel.visible = true
	
func disable_skill_button_panel():
	_skill_button_panel.set_process_input(false)
	_skill_button_panel.visible = false




#=== Skill Panel ===#

func enable_skill_panel():
	_skill_panel.on_open_panel()

func disable_skill_panel():
	_skill_panel.on_close_panel()


func set_skills_on_panel(skill_list):
	_skill_panel.add_skills(skill_list)

func clear_skills_from_panel():
	_skill_panel.clear_skills()


#=== Bag Button Panel ===#

func enable_bag_button_panel():
	_bag_button_panel.set_process_input(true)
	_bag_button_panel.visible = true
	
func disable_bag_button_panel():
	_bag_button_panel.set_process_input(false)
	_bag_button_panel.visible = false
	
#=== Bag Panel ===#

func enable_bag_panel():
	_bag_panel.on_open_panel()

func disable_bag_panel():
	_bag_panel.on_close_panel()

#=== Update Values ===#

func set_speed_label(new_speed):
	_speed_label.visible = true
	_speed_label.set_speed(new_speed)

func hide_speed_label():
	_speed_label.visible = false
