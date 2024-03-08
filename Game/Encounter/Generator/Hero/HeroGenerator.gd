extends Node

#=== About ===#
# Generates heros based on a series of parameters. The generated data is then applied to a blank Hero class to create a new custom hero.


#=== Prefabs ===#
const _hero_template = preload("res://Character/Hero/Hero.tscn")
const _attributes_template = preload("res://Character/Data/Attributes.gd")
const _modifiers_template = preload("res://Character/Data/Modifiers.gd")
const _skills_template = preload("res://Character/Data/Skills.gd")
const _stats_template = preload("res://Character/Data/Stats.gd")

const _arcane_blast_template = preload("res://Character/Skills/SkillList/Wizard/ArcaneBlast.gd")


#=== Variables ===#
var _hero_data # originally just the class_id and level, but other info is then appended
var _name_pool = ["Tim", "Mob", "Casul", "Boioioing"]
var _drafted_names = []


#=== Bootstrap ===#

func generate_hero(hero_data):
	_hero_data = hero_data
	var hero = _hero_template.instantiate()
	match _hero_data.hero_class:
		"Wizard":
			generate_new_wizard(hero)
	_hero_data = {}
	restore_drafted_names()
	return hero



#=== Wizard ===#

# Generate a new wizard character.
func generate_new_wizard(wizard):
	_hero_data.name = draft_random_hero_name()
	create_wizard_attributes()
	create_wizard_stats()
	create_modifiers(wizard)
	create_wizard_skills()
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
		"health": 10,
		"physical_defense": 2,
		"max_equipment_weight": 20,
		
		"speed": 2,
		"evasion": 3,
		"crit_damage": 5,

		"crit_chance": 2,
		"magical_defense": 6,
	}
	
	_hero_data.stats = create_base_stats(base_stats)
	_hero_data.stats.add_stats_based_on_attributes(_hero_data.attributes)


func create_wizard_skills():
	var skill_list = []
	var arcane_blast = _arcane_blast_template.new()
	skill_list.append(arcane_blast)
	create_skills_template(skill_list)




func create_random_wizard_gear():
	pass #TODO






#=== Hero Names ===#

# Drafts a random hero name from _name_pool. Drafted names pooped from the list and 
# are added to _drafted_names, to avoid repetition. After the drafting is complete, the
# selected names are restored to _name_pool.
#TODO the names are temporarily added in order for debuggig purposes.
func draft_random_hero_name():
	var drafted_name = _name_pool.pop_front()
	_drafted_names.append(drafted_name)
	return drafted_name


# Restores the drafted names in _drafted_names back into _name_pool.
func restore_drafted_names():
	_name_pool.append_array(_drafted_names)
	_drafted_names = []





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


func create_modifiers(hero):
	var modifiers = _modifiers_template.new()
	modifiers.initialize(hero)
	_hero_data["modifiers"] = modifiers


func create_skills_template(skill_list):
	var skills = _skills_template.new()
	skills.initialize_skills(skill_list)
	_hero_data["skills"] = skills




