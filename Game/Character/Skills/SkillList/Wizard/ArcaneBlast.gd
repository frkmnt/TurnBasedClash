extends Node

# A skill used by the rat.

# Constants
const _id = "arcane_blast"
const _type = "single_target"
const _target_type = "enemy"
const _name = "Arcane Blast"
const _description = "Rains arcane magic down on the target. This attack always has 100% accuracy."


# Parameters
var _cost = 2
var _cooldown = 1
var _range = 3
var _targets = 1
var _accuracy = 90 # out of 100
var _physical_damage = [0, 0]
var _magical_damage = [30, 35]

var _needs_los = false # line of sight


# Metadata
var _cur_cooldown = 0


#=== Event Management ===#

func on_turn_start():
	_cur_cooldown -= 1


func on_target_selected(character_coords, tile_coords, target_data):
	pass


#=== Skill Effects ===#

func apply_skill(target):
	_cur_cooldown = _cooldown
	var log = "Arcane Blast was cast on " + target._name + "."
	var attack_accuracy = 200
	var can_attack = target.on_receive_attack(self, attack_accuracy)
	if can_attack:
		var damage_dealt = target.on_apply_damage(0, roll_attack(), 0)
		if damage_dealt > 0:
			log += "\n " + str(damage_dealt) + " damage was dealt."
		else: # on no damage dealt
				log += " No damage was dealt!"
	else: # on miss
		log += " " + target._name + " dodges the attack!"
	
	return log


# Rolls and returs the damage for an attack.
func roll_attack():
	return randi_range(_magical_damage[0], _magical_damage[1])






#=== Utils ===#

func is_usable():
	return _cur_cooldown <= 0


func print_skill():
	print( \
		"Name: " + str(_name) \
		+ "\nType: " + str(_type) \
		+ "\nDescription: " + str(_description) \
		+ "\nCost: " + str(_cost) \
		+ "\nCooldown: " + str(_cooldown) \
		+ "\nRange: " + str(_range) \
		+ "\nPhysical Damage: " + str(_physical_damage) \
		+ "\nCurrent Cooldown: " + str(_cur_cooldown) \
		+ "\n"
	)

