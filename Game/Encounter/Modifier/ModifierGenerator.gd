extends Node2D

# This node instances modifiers based on their associated id.
# All modifiers are preloaded at the start of the dungeon bootstrap, ready to be instanced.
# Modifiers have associated types that indicate when and how they should behave.




#==== Variables ====#
var _modifier_map = {} # map of modifier id: modifier_prefab




#==== Bootstrap ====#

# Function called on bootstrap of the dungeon instance.
func initialize():
	initialize_modifier_prefabs()


# Initialize all the modifiers and bind them to their respective IDs.
func initialize_modifier_prefabs():
	var modifier
	var directory_path = "res://Encounter/Modifier/Modifiers/"
	var directory = DirAccess.open(directory_path) # handles the iteration of all modifiers
	if directory:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		# start iterating the modifier directories
		while file_name != "":
			if directory.current_is_dir():
				print("Found directory: " + file_name)
				modifier = load(directory_path + "/" + file_name + "/Poison.gd")
				_modifier_map[modifier._id] = modifier
			file_name = directory.get_next()





#==== Modifier Generation ====#
func get_modifier_instance(modifier_id):
	return _modifier_map[modifier_id].new()
