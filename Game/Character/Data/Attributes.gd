extends Node

#=== About ===#
# This class is the container for the character's calculated stats.
# Strength -> Determines the total health, physical defense and carry weight.
# Dexterity -> Determines the speed, evasion and crit damage.
# Intelligence -> Determines the total mana, crit chance and magical defense.



#=== Variables ===#
var _strength = 0
var _dexterity = 0
var _intelligence = 0

var _cur_strength = 0
var _cur_dexterity = 0
var _cur_intelligence = 0




#=== Bootstrap ===#

func initialize(attribute_map):
	_strength = attribute_map.get("strength")
	_dexterity = attribute_map.get("dexterity")
	_intelligence = attribute_map.get("intelligence")
	match_current_to_base_attributes()




#=== Mutators ===#

func add_strength(str_val):
	_cur_strength = _strength + str_val
	if _cur_strength <= 0:
		_cur_strength = 1

func add_dexterity(dex_val):
	_dexterity = _dexterity + dex_val
	if _dexterity <= 0:
		_dexterity = 1

func add_intelligence(int_val):
	_intelligence = _intelligence + int_val
	if _intelligence <= 0:
		_intelligence = 1

func match_current_to_base_attributes():
	_cur_strength = _strength
	_cur_dexterity = _dexterity
	_cur_intelligence = _intelligence


#=== Utils ===#

func print_attributes():
	print( \
		"Strength: " + str(_strength) \
		+ "\nDexterity: " + str(_dexterity) \
		+ "\nIntelligence: " + str(_intelligence) \
		+ "\n"
	)


