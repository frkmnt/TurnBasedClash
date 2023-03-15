extends Node

#=== About ===#
# Represents a basic attack, that all entities have access to.




#=== Base Values ===#

var _damage = 1
var _crit_chance = 1
var _crit_damage = 1

var _attack_range = 1 # in tiles
var _speed_cost = 1
var _cooldown = 0

#=== Modified Values ===#

var _cur_damage = 1
var _cur_crit_chance = 1
var _cur_crit_damage = 1

var _cur_attack_range = 1
var _cur_speed_cost = 1
var _cur_cooldown = 0




#=== Bootstrap ===#

func initialize(stat_map):
	_damage = stat_map.get("damage")
	_cur_crit_chance = stat_map.get("damage")
	_cur_crit_damage = stat_map.get("damage")
	
	_attack_range = stat_map.get("damage")
	_speed_cost = stat_map.get("damage")
	_cooldown = stat_map.get("damage")
	
	match_current_to_base_stats()




#=== Modifiers ===#

func set_damage(new_dmg):
	_cur_damage = new_dmg

func reset_damage():
	_cur_damage = _damage


func set_attack_range(new_atk_rng):
	_cur_attack_range = new_atk_rng

func reset_attack_range():
	_cur_attack_range = _attack_range


func set_speed_cost(new_spd_cst):
	_cur_speed_cost = new_spd_cst

func reset_speed_cost():
	_cur_speed_cost = _speed_cost


func set_cooldown(new_cdn):
	_cur_cooldown = new_cdn

func reset_cooldown():
	_cur_cooldown = _cooldown


func match_current_to_base_stats():
	_cur_damage = _damage
	_cur_crit_chance = _crit_chance
	_cur_crit_damage = _crit_damage
	_cur_attack_range = _attack_range
	_cur_speed_cost = _speed_cost
	_cur_cooldown = _cooldown




#=== Utils ===#

func get_as_map():
	return {
		"damage": _cur_damage,
		"attack_range": _cur_attack_range,
		"speed_cost": _cur_speed_cost,
		"cooldown": _cur_cooldown,
	}




