extends Node

#=== About ===#
# Generates an encounter based on custom parameters. The map, enemies, loot and all aspects of the encounter are generated to match the intended data.
# The generator and its children are deleted aftwerwards.




#=== Components ===#
var _map_generator
var _mob_generator
var _hero_generator




#=== Bootstrap ===#

func _ready():
	_map_generator = $MapGenerator
	_mob_generator = $MobGenerator
	_hero_generator = $HeroGenerator




#=== Generation ===#

func generate_encounter(biome_id, intended_level, party):
	var encounter_data
	match biome_id:
		"Test":
			encounter_data = generate_test_encounter(intended_level)
	encounter_data["party"] = generate_party(party)
	return encounter_data



#=== Test ===#

func generate_test_encounter(intended_level):
	var tilemap = generate_test_map()
	var enemy_list = generate_test_enemies(intended_level)
	return {"tilemap": tilemap, "enemies": enemy_list}


func generate_test_map():
	var map_data = {
		biome_id = "Test",
		map_size = generate_random_map_size(Vector2(6, 8), Vector2(6, 8)), 
		level = 1, 
	}
	var tilemap = _map_generator.generate_new_map(map_data)
	return tilemap


func generate_test_enemies(intended_level):
	var enemy_count = 1
	var enemy_list = []
	for i in range(enemy_count):
		enemy_list.append(_mob_generator.generate_mob({"mob_id": "Rat", "level": intended_level}))
	return enemy_list




#=== Party ===#

# Loads the party's data and generates the party structure.
func generate_party(party):
	var temp_party = [
		{
			"hero_class": "Wizard",
			"level": 1
		},
		{
			"hero_class": "Wizard",
			"level": 1
		}
	]
	
	var hero_list = []
	for hero_data in temp_party:
		hero_list.append(_hero_generator.generate_hero(hero_data))
	return hero_list




#=== Map Generation ===#

# Generates a map with a random size between x_range and y_range.
func generate_random_map_size(x_range, y_range):
	var x_size = generate_values_in_range(x_range.x, x_range.y)
	var y_size = generate_values_in_range(y_range.x, y_range.y)
	return Vector2(x_size, y_size)




#=== Utils ===#

# Generates a random value between min_val and max_val.
func generate_values_in_range(min_val, max_val):
	return randi_range(min_val, max_val)




