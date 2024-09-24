extends Node
#
## Paths to the trait scripts
#@export var health_script: Resource = preload("res://Encounter/UI/Traits/Health.gd")
#@export var speed_script: Resource = preload("res://Encounter/UI/Traits/Speed.gd")
#@export var armor_script: Resource = preload("res://Encounter/UI/Traits/Armor.gd")
#@export var slot_script: Resource = preload("res://Encounter/UI/Traits/SlotArmor.gd")
#
## Path to the gear script
#@export var gear_script: Resource = preload("res://Encounter/UI/Equipment/Gear.gd")
#
#func _ready():
#	for i in range(50):
#		randomize()  # Seed the random number generator
#		var gear = create_random_gear()
#		gear.print_stats()
#		get_parent()._list_type_slots[gear.type.index].items.append(gear)
#
## Function to create random gear
#func create_random_gear() -> Resource:
#	var new_gear = gear_script.new()
#	new_gear.type = slot_script.new()
#	# Randomly assign traits to the gear
#	if randf() < 0.8:  # 80% chance to have health
#		new_gear.health = health_script.new()
#	if randf() < 0.6:  # 60% chance to have speed
#		new_gear.speed = speed_script.new()
#	if randf() < 0.7:  # 70% chance to have armor
#		new_gear.armor = armor_script.new()
#
#	# Randomize the traits
#	new_gear.randomize_traits()
#
#	# Give the gear a random name
#	new_gear.name = "Gear " + str(randi() % 1000)
#
#	return new_gear
