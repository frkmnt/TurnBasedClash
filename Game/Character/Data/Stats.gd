extends Node

#=== About ===#
# This class is the container for the character's base stats.
# Health -> The character's total HP.
# Physical Defense -> Resistance to Physical Damage.
# Max Equipment Weight -> Determines how much equipment the character can carry.
# Speed -> Determines how fast the character has a turn. In case of a tie, the result is randomized each time. Also determines how many actions can be taken per turn.
# Evasion -> The chance a character will dodge an attack.
# Crit Damage -> The extra percentage dealt as damage.
# Mana -> Consumed when using skills.
# Crit Chance -> The chance to trigger a critical hit.
# Magical Defense -> Resistance to Magical Damage.
# Current Health -> The current HP.
# Current Mana -> The current Mana.
# Current Equipment Weight -> Determines how encumbered the character is. Each 20% of the max load increment reduces Dexterity.
# Attack Damage -> Determined by the weapon's stats.
# Luck -> Boosts Item Discovery and rare enemy spawn rates.

#TODO remove mana


#=== Variables ===#

# strength
var _health = 0 
var _cur_health = 0

var _physical_defense = 0
var _cur_physical_defense = 0

var _max_equipment_weight = 0
var _cur_max_equipment_weight = 0

# dexterity
var _speed = 0 
var _cur_speed = 0 

var _evasion = 0
var _cur_evasion = 0

var _crit_damage = 0
var _cur_crit_damage = 0

# intelligence

var _crit_chance = 0
var _cur_crit_chance = 0

var _magical_defense = 0
var _cur_magical_defense = 0




#=== Bootstrap ===#

func initialize(stat_map):
	_health = stat_map.get("health") # strength
	_physical_defense = stat_map.get("physical_defense")
	_max_equipment_weight = stat_map.get("max_equipment_weight")

	_speed = stat_map.get("speed") # dexterity
	_evasion = stat_map.get("evasion")
	_crit_damage = stat_map.get("crit_damage")

	_crit_chance = stat_map.get("crit_chance")
	_magical_defense = stat_map.get("magical_defense")

	match_current_to_base_stats()




#=== Calculate Stats ===#

func add_stats_based_on_attributes(attributes):
	add_stats_based_on_strength(attributes._strength)
	add_stats_based_on_dexterity(attributes._dexterity)
	add_stats_based_on_intelligence(attributes._intelligence)
	match_current_to_base_stats()

func add_stats_based_on_strength(strength):
	_health += 10 * strength
	_physical_defense += 2 * strength
	_max_equipment_weight += (1 * strength) + 10

func add_stats_based_on_dexterity(dexterity):
	_speed += (dexterity / 10)
	_evasion += int(dexterity/10)
	_crit_damage += dexterity * 2

func add_stats_based_on_intelligence(intelligence):
	_crit_chance += 1 + int(intelligence/10)
	_magical_defense += 5 * intelligence

func match_current_to_base_stats():
	_cur_health = _health
	_cur_physical_defense = _physical_defense
	_cur_max_equipment_weight = _max_equipment_weight
	
	_cur_speed = _speed
	_cur_evasion = _evasion
	_cur_crit_damage = _crit_damage
	
	_cur_crit_chance = _crit_chance
	_cur_magical_defense = _magical_defense


func apply_resistances_then_damage(phyical_damage, magical_damage):
	phyical_damage -= _physical_defense
	if phyical_damage > 0:
		sub_cur_health(phyical_damage)
	magical_damage -= _magical_defense
	if magical_damage > 0:
		sub_cur_health(magical_damage)



#=== Mutators ===#

func add_health(health_val):
	_health = _health + health_val
	if _health <= 0:
		pass
		#kill_character() #TODO

func sub_health(health_val):
	_health = _health - health_val
	if _health <= 0:
		pass
		#kill_character() #TODO




#=== Current Stat Mutators ===#

func add_cur_health(health_val):
	_cur_health = _cur_health + health_val
	if _cur_health <= 0:
		pass
		#kill_character() #TODO

func sub_cur_health(health_val):
	_cur_health = _cur_health - health_val
	if _cur_health <= 0:
		pass
		#kill_character() #TODO

func sub_cur_speed(speed_val):
	_cur_speed -= speed_val
	if _cur_speed <= 0:
		_cur_speed = 0
	return _cur_speed




#=== Turn Management ===#

func on_turn_start():
	_cur_speed = _speed



#=== Utils ===#

func print_attributes():
	print( \
		"Health Points: " + str(_health) \
		+ "\nPhysical Defense: " + str(_physical_defense) \
		+ "\nMax Equipment Weight: " + str(_max_equipment_weight) \
		+ "\nSpeed: " + str(_speed) \
		+ "\nEvasion: " + str(_evasion) \
		+ "\nCrit Damage: " + str(100+_crit_damage) \
		+ "\nCrit Chance: " + str(_crit_chance) \
		+ "\nMagical Defense: " + str(_magical_defense) \
		+ "\n"
	)
