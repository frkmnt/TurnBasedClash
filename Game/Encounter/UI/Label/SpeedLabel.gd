extends Node

#=== About ===#
# This class manages the speed label, which indicates the current character's current speed.


#=== Components ===#
var _label

#=== Variables ===#
var _cur_speed = 0


#=== Bootstrap ===#

func _ready():
	_label = $Label



#=== Change Values ===#

func set_speed(speed):
	_cur_speed = speed
	_label.text = str(_cur_speed)



#=== Animations ===#

# TODO add animation handling
