extends Node

#=== About ===#
# Generates heros based on a series of parameters. The generated data is then applied to a blank Hero class to create a new custom hero.


#=== Prefabs ===#
const _hero_template = preload("res://Character/Hero/Hero.tscn")
const _attributes_template = preload("res://Character/Modifiers/Attributes.gd")
const _stats_template = preload("res://Character/Modifiers/Stats.gd")


#=== Variables ===#
var _hero_data # originally just the class_id and level, but other info is then appended



#=== Bootstrap ===#

func generate_hero(hero_data):
	_hero_data = hero_data
	var hero = _hero_template.instantiate()
	match _hero_data.hero_class:
		"Wizard":
			generate_new_wizard(hero)
	_hero_data = {}
	return hero



#=== Wizard ===#

func generate_new_wizard(wizard):
	_hero_data.name = "Tim"
	create_wizard_attributes()
	create_wizard_stats()
	
	wizard.initialize(_hero_data)
	return wizard

func create_wizard_attributes():
	var base_attributes = {
		"strength": 5,
		"dexterity": 5,
		"intelligence": 13,
	}
	_hero_data.attributes = create_base_attributes(base_attributes)
	var attribute_increments = [2, 2, 8]
	add_level_up_attributes(_hero_data.attributes, _hero_data.level, attribute_increments)

func create_wizard_stats():
	var base_stats = {
		"health": 300,
		"physical_defense": 20,
		"max_equipment_weight": 20,
		
		"speed": 2,
		"evasion": 3,
		"crit_damage": 5,
		
		"mana": 300,
		"crit_chance": 2,
		"magical_defense": 60,
	}
	
	_hero_data.stats = create_base_stats(base_stats)
	create_stats_from_attributes(_hero_data.stats)




func create_random_wizard_gear():
	pass #TODO





#=== Utils ===#

func create_base_attributes(base_attributes_map):
	var attributes = _attributes_template.new()
	attributes.initialize(base_attributes_map)
	return attributes

func add_level_up_attributes(attributes, level, attribute_increments):
	attributes.add_strength(attribute_increments[0] * level)
	attributes.add_dexterity(attribute_increments[1] * level)
	attributes.add_intelligence(attribute_increments[2] * level)


func create_base_stats(base_stats_map):
	var stats = _stats_template.new()
	stats.initialize(base_stats_map)
	return stats

func create_stats_from_attributes(stats):
	stats.add_stats_based_on_attributes(_hero_data.attributes)


func create_traits():
	pass
