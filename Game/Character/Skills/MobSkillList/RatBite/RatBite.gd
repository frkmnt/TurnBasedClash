extends Node

# A skill used by the rat.

# Constants
var _id = "rat_bite"
var _name = "Rat Bite"
var _type = "Target"
var _description = "A nasty bite with a small chance of infection."

# Parameters
var _cost = 2
var _cooldown = 1
var _range = 1
var _physical_damage = 6

# Metadata
var _cur_cooldown = 1




#=== Bootstrap ===#




#=== Event Management ===#

func on_turn_start():
	if _cur_cooldown < 0:
		_cur_cooldown = _cooldown




#=== Skill Effects ===#

func apply_skill(target):
	print("HP Before: ", target._stats._cur_health)
	target.on_receive_attack(self)
	target.on_apply_damage(_physical_damage, 0, [])
	_cur_cooldown -= 1
	print("HP After: ", target._stats._cur_health)




#=== Utils ===#

func is_usable():
	return _cur_cooldown == _cooldown
