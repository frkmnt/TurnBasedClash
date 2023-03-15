extends Node

#=== About ===#
# This class randomly generates a tilemap, that is then returned before self-destructing the class.
# TODO implement the wave function collapse random gen algorithm. 


#=== Constants ===#
const _ASSET_PATH = "res://Asset/Encounter/Biome/"
const _BIOME_DATA_GENERATOR = preload("res://Encounter/Generator/Map/BiomeDataGenerator.gd")

#=== Variables ===#
var _map_data
var _biome_data
var _tile_map # the tilemap to be generated



#=== Bootstrap ===#

func generate_new_map(map_data):
	randomize()
	_map_data = map_data
	_biome_data = create_biome_data()
	var tileset = load_tileset()
	generate_blank_tilemap(tileset)
	generate_map()
	_tile_map.startup_components()
	remove_child(_tile_map)
	return _tile_map

func create_biome_data():
	var biome_data_generator = _BIOME_DATA_GENERATOR.new()
	return biome_data_generator.get_biome_data(_map_data.biome_id)


func load_tileset():
	var directory_path = "res://Asset/Encounter/Biome/" + _map_data.biome_id
	var dir = Directory.new()
	dir.open(directory_path)
	var tileset = load(dir.get_current_dir() + "/Tileset.tres")
	return tileset


func generate_blank_tilemap(tileset):
	_tile_map = $Map
	_tile_map.initialize(tileset, _map_data)








#=== Generation ===#

func generate_map():
	generate_borders()
	generate_floor()

func generate_borders(): # TODO may need optimization due to repetitive get_random_tile_of_type call
	var tile_data = _biome_data.tile_data
	var map_size = _map_data.map_size
	for x in range(1, map_size.x):
		_tile_map.set_tile_at_coords(Vector2(x,0), get_random_tile_of_type(tile_data, "wall_up"), tile_data.wall_up.tile_data)
		_tile_map.set_tile_at_coords(Vector2(x,map_size.y), get_random_tile_of_type(tile_data, "wall_down"), tile_data.wall_down.tile_data)
	for y in range(1, map_size.y):
		_tile_map.set_tile_at_coords(Vector2(0,y), get_random_tile_of_type(tile_data, "wall_left"), tile_data.wall_left.tile_data)
		_tile_map.set_tile_at_coords(Vector2(map_size.x,y), get_random_tile_of_type(tile_data, "wall_right"), tile_data.wall_right.tile_data)
	_tile_map.set_tile_at_coords(Vector2(0,0), get_random_tile_of_type(tile_data, "corner_up_left"), tile_data.corner_up_left.tile_data)
	_tile_map.set_tile_at_coords(Vector2(map_size.x,0), get_random_tile_of_type(tile_data, "corner_up_right"), tile_data.corner_up_right.tile_data)
	_tile_map.set_tile_at_coords(Vector2(0, map_size.y), get_random_tile_of_type(tile_data, "corner_down_left"), tile_data.corner_down_left.tile_data)
	_tile_map.set_tile_at_coords(Vector2(map_size.x, map_size.y), get_random_tile_of_type(tile_data, "corner_down_right"), tile_data.corner_down_right.tile_data)






func generate_floor():
	var tile_data = _biome_data.tile_data
	var map_size = _map_data.map_size
	for x in range(1, map_size.x):
		for y in range(1, map_size.y):
			_tile_map.set_tile_at_coords(Vector2(x,y), get_random_tile_of_type(tile_data, "grass"), tile_data.grass.tile_data)





#=== Util ===#

func get_random_tile_of_type(tile_data, type):
	var possible_tiles = tile_data.get(type).tileset_coords
	return possible_tiles[randi_range(0, possible_tiles.size()-1)]








