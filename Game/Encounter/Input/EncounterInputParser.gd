extends Node2D

#=== About ===#
# Parses the inputs from signals emitted by the InputManager Singleton.


#=== References ===#
var _encounter_manager # this node's intended parent

#=== Variables ===#

# Locks that control the different inputs.
var _can_move_camera = false
#var _can_zoom = false

var _can_attack = false
var _can_skill = false
var _can_move = false
var _can_bag = false
var _can_pass = false
var _can_inspect = false



#=== Bootstrap ===#

func initialize():
	_encounter_manager = get_parent()



#=== Signal ===#

func parse_action_input(action_input):
	match action_input:
		"attack":
			on_attack()
		"skill":
			on_skill()
		"move":
			on_move()
		"bag":
			on_bag()
		"pass":
			on_pass()
		"inspect":
			on_inspect()


func parse_mouse_input(mouse_input):
	match mouse_input:
		"1":
			on_left_click()
		"4":
			on_zoom_in()
		"5":
			on_zoom_out()


func parse_mouse_motion():
	if _can_move_camera:
		if InputManager._is_dragging:
			on_mouse_drag()





#=== Parsing Inputs ===#

func on_left_click():
	_encounter_manager.handle_left_click()

func on_mouse_drag():
	if _encounter_manager._mode == "camera":
		_encounter_manager._camera.set_new_position(InputManager._drag_vector)

func on_zoom_in():
	if _can_move_camera:
		_encounter_manager._camera.on_zoom_in()

func on_zoom_out():
	if _can_move_camera:
		_encounter_manager._camera.on_zoom_out()





#=== Parsing Buttons ===#

func on_move():
	if _can_move:
		_encounter_manager.set_mode_button("move")
	
func on_attack():
	if _can_attack:
		_encounter_manager.set_mode_button("attack")

func on_skill():
	if _can_skill:
		_encounter_manager.set_mode_button("skill")

func on_bag():
	if _can_bag:
		_encounter_manager.set_mode_button("bag")

func on_pass():
	if _can_pass:
		_encounter_manager.set_mode_button("pass")

func on_inspect():
	if _can_inspect:
		_encounter_manager.set_mode_button("inspect")





#=== Utils ===#

# Updates the camera move lock status based on can_move.
func set_can_move_camera(can_move):
	_can_move_camera = can_move


# Updates multiple button lock settings at once. 
# Receives an array with all otptions that need to be altered, 
# with elements of type [button_id, can_use]
func update_button_locks(button_lock_list):
	for button_data in button_lock_list:
		match button_data[0]:
			"can_attack":
				_can_attack = button_data[1]
			"can_skill":
				_can_skill = button_data[1]
			"can_move":
				_can_move = button_data[1]
			"can_bag":
				_can_bag = button_data[1]
			"can_pass":
				_can_pass = button_data[1]
			"can_inspect":
				_can_inspect = button_data[1]


# Updates all the button types to the desired lock.
func update_all_button_locks(can_use):
	_can_attack = can_use
	_can_skill = can_use
	_can_move = can_use
	_can_bag = can_use
	_can_pass = can_use
	_can_inspect = can_use
