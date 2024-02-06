extends Node

#=== About ===#
# A generic abstraction of the encounter button. 
# These buttons allow the user to switch between different actions, such as using an item or attacking.


#=== References ===#
var _parent

#=== Variables ===#
@export var _id  = ""



#=== Bootstrap ===#

func _ready():
	#TODO improve
	_parent = get_parent().get_parent().get_parent()



#=== Signals ===#

func on_toggled(_is_pressed):
	_parent.on_button_pressed(_id)
