extends Node

var _range
var _physical_damage
var _magical_damage
var _raw_damage
var _cost

var _modifiers = []


# Bootstrap

func initialize(atk_range, physical, magical, raw, cost):
	_range = atk_range
	_physical_damage = physical
	_magical_damage = magical
	_raw_damage = raw
	_cost = cost




# Getters/Setters

func get_physical_damage_with_reduction(value):
	return apply_damage_reduction(_physical_damage, value)

func get_magical_damage_with_reduction(value):
	return apply_damage_reduction(_magical_damage, value)






# Value Manipulators

func add_physical_attack(value):
	_physical_damage += value

func add_magical_attack(value):
	_magical_damage += value

func add_raw_attack(value):
	_raw_damage += value

func subtract_physical_attack(value):
	_physical_damage -= value
	if _physical_damage <= 0:
		_physical_damage = 0

func subtract_magical_attack(value):
	_magical_damage -= value
	if _magical_damage <= 0:
		_magical_damage = 0

func subtract_raw_attack(value):
	_raw_damage -= value
	if _raw_damage <= 0:
		_raw_damage = 0

func apply_damage_reduction(damage_type, value):
	var damage = damage_type
	damage -= value
	if damage <= 0:
		damage = 0
	return damage





func add_modifier(modifier):
	_modifiers.append(modifier)














