extends Node

# Receive small instances of damage at the start of your turn.

#=== Constants ===#
const _modifier_id = "poison"
const _types = ["damage"]
const _triggers = ["turn_end"]
const _max_stacks = 5

#=== Variables ===#
var _bound_character
var _needs_to_be_removed = false
var _total_stacks = 0




#=== Bootstrap ===#

func bind_to_character(character_to_bind):
	_bound_character = character_to_bind




#=== Interaction ===#

func on_turn_end():
	var damage_to_deal = match_stacks_to_damage()
	_bound_character._stats.sub_health(damage_to_deal)
	print("health after poison ", _bound_character._stats._cur_health)
	remove_stacks(1)



func remove_stacks(amount):
	_total_stacks -= 1
	if _total_stacks <= 0:
		_needs_to_be_removed = true


func remove():
	queue_free()




#=== Utils ===#

func match_stacks_to_damage():
	var damage_to_deal = 0
	match _total_stacks:
		1:
			damage_to_deal = 1
		2:
			damage_to_deal = 1
		3:
			damage_to_deal = 2
		4:
			damage_to_deal = 2
		5:
			damage_to_deal = 3
	return damage_to_deal
