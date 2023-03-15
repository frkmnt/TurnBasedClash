extends Node2D

#=== About ===#
# Parses the inputs from signals emitted by the InputManager Singleton.


#=== References ===#
var _encounter_manager # this node's intended parent

#=== Variables ===#
var _can_input = false



#=== Bootstrap ===#

func initialize():
	_encounter_manager = get_parent()



#=== Signal ===#

func parse_action_input(action_input):
	if not _can_input:
		return
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
		"zoom_in":
			on_zoom_in()
		"zoom_out":
			on_zoom_out()


func parse_mouse_input(mouse_input):
	if not _can_input:
		return
	match mouse_input:
		"1":
			on_left_click()
		"4":
			on_zoom_in()
		"5":
			on_zoom_out()


func parse_mouse_motion():
	if not _can_input:
		return
	if InputManager._is_dragging:
		on_mouse_drag()



#=== Parsing ===#

func on_left_click():
	_encounter_manager.handle_left_click()

func on_mouse_drag():
	if _encounter_manager._mode != "camera":
		return
	_encounter_manager._camera.set_new_position(InputManager._drag_vector)


func on_move():
	_encounter_manager.set_mode("move")
	
func on_attack():
	_encounter_manager.set_mode("attack")

func on_skill():
	_encounter_manager.set_mode("skill")

func on_bag():
	_encounter_manager.set_mode("bag")

func on_pass():
	_encounter_manager.set_mode("pass")

func on_inspect():
	_encounter_manager.set_mode("inspect")

func on_zoom_in():
	_encounter_manager._camera.on_zoom_in()

func on_zoom_out():
	_encounter_manager._camera.on_zoom_out()




#=== Utils ===#

func set_can_input(can_input):
	_can_input = can_input




