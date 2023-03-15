extends Node


#=== Variables ===#
var _moveable = true
var _move_cost = 1
var _damage_on_enter = 0


#=== Bootstrap ===#

func initialize(moveable, move_cost, damage_on_enter):
	_moveable = moveable
	_move_cost = move_cost
	_damage_on_enter = damage_on_enter

