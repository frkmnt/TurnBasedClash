extends Node

#=== About ===#
# This singleton process inputs and emits events based on them, that can later be parsed into inputs by different actions.
# EncounterInputParser -> Parses inputs when inside a combat encounter.


#=== Constants ===#
const _action_inputs = ["attack", "skill", "move", "bag", "run", "1", "2", "3", "4",]

#=== Variables ===#
var _action_input = ""
var _mouse_input = ""
var _drag_vector = Vector2(0, 0)
var _click_pos = Vector2(0, 0)
var _is_dragging = false



#=== Bootstrap ===#

func _ready():
	pass


#=== Input Processing ===#

func _physics_process(_delta):
	process_all_inputs()


# Processes all possible inputs and handles them accordingly.
func process_all_inputs():
	if not Input.is_anything_pressed():
		return
	reset_actions()
	assign_action_input()
	if _action_input != "":
		print("pressed " + _action_input)
		SignalManager.emit_signal("_on_action_input", _action_input)


# Resets the action modes to "".
func reset_actions():
	_action_input = ""
	_mouse_input = ""
	_drag_vector = Vector2(0, 0)


# Iterate all action inputs and handle each accordingly.
func assign_action_input():
	for action in _action_inputs:
		if Input.is_action_just_pressed(action):
			_action_input = action
			return




#=== Handle Touch UI Inputs ===#

# Handles mouse/touchscreen inputs on the screen.
func _input(event):
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		match event.button_index:
			1: # lmb
				if event.pressed: # mouse press
					_mouse_input = "1"
					_is_dragging = true
					_click_pos = event.global_position
					SignalManager.emit_signal("_on_mouse_input", _mouse_input)
				else: # mouse release
					_is_dragging = false
			
			4: # mouse_wheel_up
				if event.pressed:
					_mouse_input = "4"
					SignalManager.emit_signal("_on_mouse_input", _mouse_input)
			
			5: # mouse_wheel_down
				if event.pressed:
					_mouse_input = "5"
					
					SignalManager.emit_signal("_on_mouse_input", _mouse_input)
		
	elif event is InputEventMouseMotion or event is InputEventScreenDrag: # mouse drag 
		_drag_vector = event.relative
		SignalManager.emit_signal("_on_mouse_motion")

