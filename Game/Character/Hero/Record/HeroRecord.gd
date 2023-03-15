extends Node

#=== About ===#
# This class is a lightweight container for all hero data. It can be passed into the hero generator
# to create a replica of the hero with in-game mechanics included.


#=== Variables ===#

var _attributes = {
	"strength": 0,
	"dexterity": 0,
	"intelligence": 0,
}

var _stats = {
	"health": 0,
	"physical_defense": 0,
	"max_equipment_weight": 0,
	"speed": 0,
	"evasion": 0,
	"crit_damage": 0,
	"mana": 0,
	"crit_chance": 0,
	"magical_defense": 0,
	"luck": 0,
}



#=== Bootstrap ===#

func initialize(attributes, stats):
	pass
