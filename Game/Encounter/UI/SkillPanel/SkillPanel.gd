extends Panel

# UI Menu that contains a list of all the current hero's skills.
# All the skills are added to the menu at the start of the turn.

#=== Constants ===#
const _skill_panel_item = preload("res://Encounter/UI/SkillPanel/SkillPanelItem.tscn")


#==== Components ====#
var _menu_title
var _skill_container



#==== Bootstrap ====#

# Initialize the skill panel at the start of combat.
func _ready():
	pass
	_menu_title = $Title
	_skill_container = $SkillContainer/VBoxContainer




#==== Logic ====#

# Clear all the skills from the Skill Container. Called on_turn_end.

func clear_skills():
	for skill in _skill_container:
		skill.queue_free()


# Add a list of skills to the skill panel. Called on_turn_start.
func add_skills(skill_list):
	for skill in skill_list:
		add_skill(skill)


# Add a single skill to the skill panel. Called individually by add_skills.
func add_skill(skill):
	var skill_panel_item = _skill_panel_item.instantiate()
	_skill_container.add_child(skill_panel_item)
	skill_panel_item.initialize(skill)




#==== UI Interaction ====#

# Make the panel visible and enable the skill's input processing.
func on_close_panel():
	visible = false
	set_skill_process_input(false)


# Make the panel invisible and disable the skill's input processing.
func on_open_panel():
	visible = true
	set_skill_process_input(true)


# Enable/disable the skill's input processing.
func set_skill_process_input(is_processing):
	for skill_button in _skill_container.get_children():
		skill_button.set_process_input(is_processing)
