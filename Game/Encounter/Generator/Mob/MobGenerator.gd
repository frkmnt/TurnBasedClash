extends Node

#=== About ===#
# Generates mobs based on a series of parameters. The generated data is then applied to 
# the specific mob class to create a new custom mob. This only generates parameters that are not exclusive
# to specific characters, such as their Stats, Attribute and the Modifier Manager.



#=== Prefabs ===#
const _attributes_template = preload("res://Character/Data/Attributes.gd")
const _stats_template = preload("res://Character/Data/Stats.gd")
const _modifiers_template = preload("res://Character/Data/Modifiers.gd")
const _skills_template = preload("res://Character/Data/Skills.gd")
const _basic_attack_template = preload("res://Character/BasicAttack/BasicAttack.gd")

const _rat_prefab = preload("res://Character/Mob/Rat/Rat.tscn")


#=== Variables ===#

# Local access variable that contains the data of the mob currently being generated. 
# Once done, it is reset for the next mob generation. The data parameters are 
# Attributes, Stats and the Modifier Manager.
var _mob_data




#=== Spawner ===#

func generate_mob(mob_data):
	_mob_data = mob_data
	var mob
	match _mob_data.mob_id:
		"Rat":
			mob = generate_new_rat()
	_mob_data = {}
	return mob




#=== Rat ===#

const rat_bite = preload("res://Character/Skills/MobSkillList/Rat/RatBite.gd")

func generate_new_rat():
	var rat_instance = _rat_prefab.instantiate()
	create_rat_attributes()
	create_rat_stats()
	create_modifier_manager(rat_instance)
	create_rat_skills_template()
	rat_instance.initialize(_mob_data)
	return rat_instance


func create_rat_attributes():
	var base_attributes = {
		"strength": 2,
		"dexterity": 6,
		"intelligence": 1,
	}
	_mob_data["attributes"] = create_base_attributes(base_attributes)
	var attribute_increments = [0, 1, 0]
	add_level_up_attributes(_mob_data.attributes, _mob_data.level, attribute_increments)


func create_rat_stats():
	var base_stats = {
		"health": 80,
		"physical_defense": 5,
		"max_equipment_weight": 0,
		
		"speed": 5,
		"evasion": 5,
		"crit_damage": 5,
		
		"mana": 300,
		"crit_chance": 2,
		"magical_defense": 0,
	}
	_mob_data["stats"] = create_base_stats(base_stats)
	create_stats_from_attributes(_mob_data["stats"], _mob_data["attributes"])


func create_random_rat_stats(level):
	var attributes = _attributes_template.new()
	var attribute_ranges = [ # min-max increment per level of str, dex and int respectively
		[0,1], [1,2], [0,0]
	]
	for lvl in range(level):
		attributes.add_strength(randi_range(attribute_ranges[0][0], attribute_ranges[0][1]))
		attributes.add_dexterity(randi_range(attribute_ranges[1][0], attribute_ranges[1][1]))
		attributes.add_intelligence(randi_range(attribute_ranges[2][0], attribute_ranges[2][1]))
	return attributes


func create_rat_skills_template():
	var skills = create_skills_template()
	var skill_list = [rat_bite.new()]
	skills.initialize(skill_list)




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

func create_stats_from_attributes(stats, attributes):
	stats.add_stats_based_on_attributes(attributes)


func create_modifier_manager(mob):
	var modifiers = _modifiers_template.new()
	modifiers.initialize(mob)
	_mob_data["modifiers"] = modifiers


func create_skills_template():
	var skills = _skills_template.new()
	_mob_data["skills"] = skills
	return skills
