extends Node

# Receive small instances of damage at the start of your turn.

#=== Constants ===#
const _id = "poison"
const _types = ["damage"]
const _triggers = ["turn_start"]
const _max_stacks = 5

#=== Variables ===#
var _bound_character
var _needs_to_be_removed = false
var _total_stacks = 0




#=== Bootstrap ===#

func initialize(character_to_bind):
	_bound_character = character_to_bind




#=== Interaction ===#

func on_turn_start():
	var damage_to_deal = match_stacks_to_damage()
	var damage_dealt = _bound_character.on_apply_damage(0, 0, damage_to_deal)
	var log = str(damage_dealt) + " damage taken due to Poison."
	remove_stacks(1)
	if _needs_to_be_removed:
		log += " Poison has expired."
	return log


func remove():
	queue_free()




#=== Stacks ===#

func on_stack(new_poison):
	add_stacks(new_poison._total_stacks)


func add_stacks(amount):
	_total_stacks += amount
	if _total_stacks >= _max_stacks:
		_total_stacks = _max_stacks

func remove_stacks(amount):
	_total_stacks -= amount
	if _total_stacks <= 0:
		_needs_to_be_removed = true



#=== Utils ===#

func match_stacks_to_damage():
	var damage_to_deal = 0
	match _total_stacks:
		1:
			damage_to_deal = 3
		2:
			damage_to_deal = 6
		3:
			damage_to_deal = 10
		4:
			damage_to_deal = 14
		5:
			damage_to_deal = 20
	return damage_to_deal
