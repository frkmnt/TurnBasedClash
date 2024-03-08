extends Button

#=== About ===#
# A generic abstraction of the encounter button. 
# These buttons allow the user to switch between different actions, such as using an item or attacking.
# The button is toggleable, but it is set to unpressed by default when clicked, since the visual appearance
# and interaction logic of each button is handles by the EncounterInputManager.

#=== Variables ===#
@export var _id  = ""



#=== Signals ===#

func on_button_up():
	set_pressed_no_signal(false)
	SignalManager.emit_signal("_on_button_pressed", _id)
