extends Node

# Targeting contains tile targeting information: tiles (valid tiles), is_multi_target.


var _name # randomly generated based on parameters
var _rarity

var _targeting # {tiles, i_in_ranges_multi_target}
var _damage_types # [([damage_interval], "type")]
var _modifiers #SEE: Traits
#TODO more parameters 

var _expiration #TODO number of runs/uses?




#=== Utils ===#

func build_weapon_name():
	var weapon_name = _rarity
	for targeting_type in _targeting.keys():
		weapon_name += " " + targeting_type
	return weapon_name

func print_stats():
	print(
		"Weapon: ", _name,
		"\nRarity: ", _rarity,
		"\nTargeting: ", _targeting.keys(),
		"\nDamage Types: ", _damage_types,
		"\nExpiration: ", _expiration,
		"\n\n"
	)

func print_damage():
	print(
		"Damage Types: ", _damage_types,
	)
