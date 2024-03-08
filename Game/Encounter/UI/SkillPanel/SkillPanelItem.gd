extends Button

#==== References ====#
var r_parent_menu

#==== Components ====#
var _name
var _description
var _cost
var _cooldown

#=== Variables ===#
var _bound_skill



#==== Bootstrap ====#

func _ready():
	_name = $SkillName
	_description = $SkillDescription
	_cost = $SkillCost
	_cooldown = $SkillCooldown
	


func initialize(skill):
	_bound_skill = skill
	_name.text = skill._name
	_description.text = skill._description
	update_cost(skill._cost)
	update_cooldown(skill._cooldown)



#=== Logic ===#

func update_cost(cost):
	_cost.text = "Cost: " + str(cost)

func update_cooldown(cooldown):
	_cooldown.text = "Cooldown: " + str(cooldown)


#==== UI Interaction ====#

func on_button_released():
	print(_name.text)
	SignalManager.emit_signal("_on_skill_selected", _bound_skill)
