extends Node

#=== About ===#
# A class that is instantiated when biome data needs to be provided, usually by the map generator.
# This data can include what coordinates correspond to a tile_id, what mobs can spawn, among other parameters.


#=== Prefabs ===#
var _tile_data_prefab = preload("res://Encounter/Map/Tiles/TileData.gd")



#=== Bootstrap ===#

func get_biome_data(biome_id):
	var biome_data
	match biome_id:
		"Test":
			biome_data = get_test_data()
	return biome_data



#=== Test ===#

func get_test_data():
	var tile_data = {
		"wall_up": {"tileset_coords": [Vector2(1,0)], "tile_data": create_new_tile_data(false, 1, 0)},
		"wall_down": {"tileset_coords": [Vector2(15,10)], "tile_data": create_new_tile_data(false, 1, 0)},
		"wall_left": {"tileset_coords": [Vector2(0,1), Vector2(0,2), Vector2(0,3), Vector2(0,4)], "tile_data": create_new_tile_data(false, 1, 0)},
		"wall_right": {"tileset_coords": [Vector2(10,6), Vector2(25,0)], "tile_data": create_new_tile_data(false, 1, 0)},
		"grass": {"tileset_coords": [Vector2(1,1)], "tile_data": create_new_tile_data(true, 1, 0)},
		"corner_up_left": {"tileset_coords": [Vector2(0,0)], "tile_data": create_new_tile_data(false, 1, 0)},
		"corner_up_right": {"tileset_coords": [Vector2(25,0)], "tile_data": create_new_tile_data(false, 1, 0)},
		"corner_down_left": {"tileset_coords": [Vector2(15,10)], "tile_data": create_new_tile_data(false, 1, 0)},
		"corner_down_right": {"tileset_coords": [Vector2(15,10)], "tile_data": create_new_tile_data(false, 1, 0)},
	}

	var biome_data = {
		"tile_data": tile_data
	}
	return biome_data


func get_test_tileset():
	return




#=== Utils ===#

func create_new_tile_data(moveable, move_cost, damage_on_enter):
	var tile_data = _tile_data_prefab.new()
	tile_data.initialize(moveable, move_cost, damage_on_enter)
	return tile_data




