extends Node

# A skill used by the rat.

# Modifiers
const _poison = preload("res://Encounter/Modifier/Modifiers/Poison/Poison.gd")

# Constants
const _id = "rat_bite"
const _type = "single_target"
const _target_type = "enemy"
const _name = "Rat Bite"
const _description = "A nasty bite with a small chance of infection."


# Parameters
var _cost = 2
var _cooldown = 0
var _range = 1
var _accuracy = 80 # out of 100
var _physical_damage = [30, 60]
var _magical_damage = [0, 0]

var _needs_los = true # line of sight

var _poison_chance = 30 # out of 100

# Metadata
var _cur_cooldown = 0 # Turns remaining until active


#=== Event Management ===#

func on_turn_start():
	_cur_cooldown -= 1




#=== Skill Effects ===#

func apply_skill(target):
	_cur_cooldown = _cooldown
	var log = "The Rat uses Rat Bite on " + target._name + "."
	var attack_accuracy = roll_accuracy()
	var can_attack = target.on_receive_attack(self, attack_accuracy)
	if can_attack:
		var damage_dealt = target.on_apply_damage(roll_attack(), 0, 0)
		if damage_dealt > 0:
			log += "\n " + str(damage_dealt) + " damage was dealt."
			if roll_poison():
				var poison = _poison.new()
				poison._total_stacks = 1
				var was_applied = target.on_receive_modifier(poison)
				if was_applied:
					log += " Poison was inflicted!"
		else: # on no damage dealt
				log += " No damage was dealt!"
	else: # on miss
		log += " " + target._name + " dodges the attack!"
	
	return log

# Rolls and returs the damage for an attack.
func roll_accuracy():
	return randi_range(0, _accuracy)

# Rolls and returs the damage for an attack.
func roll_attack():
	return randi_range(_physical_damage[0], _physical_damage[1])


# Rolls for a chance to poison and returns true if it was successful.
func roll_poison():
	var has_poison = randi_range(0, 100)
	return has_poison <= _poison_chance



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

