extends Node

# This class is a container for a character's skills and cooldowns.


#=== Variables ===#

# A map of all the character's skills, of type skill_id : skill_data
var _skill_map = {}

#=== Bootstrap ===#

func initialize(skill_list):
	initialize_skills(skill_list)


# Initialize the skill list by assigning the passed skills.
func initialize_skills(skill_list):
	for skill in skill_list:
		_skill_map[skill._id] = skill




#=== Event Management ===#

# Applies turn start effects to all skills.
func on_turn_start():
	for skill in _skill_map.values():
		if skill.has_method("on_turn_start"):
			skill.on_turn_start()




#=== Skill Interaction ===#

# Handles the behaviour when the skill is selected but before confirming its use.
func select_skill(skill_id):
	_skill_map[skill_id].on_select()


# Applies the selected skill, based on skill_selection_behaviour.
func use_skill(skill_id, skill_selection_data):
	_skill_map[skill_id].on_select(skill_selection_data)


# Returns the selected skill.
func get_skill(skill_id):
	return _skill_map[skill_id]
