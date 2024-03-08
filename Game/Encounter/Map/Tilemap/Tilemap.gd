extends TileMap

#=== About ===#
# This class manages the tilemap used as the base map. It contains the information of every tile generated for an encounter 
# Inner operations such as validating a tile's data, setting objects on tiles.
# TODO optimize to use PackedVector2Array


#=== Components ===#
var _grid_highlighter
var _tile_highlighter
var _tile_navigator

#=== Variables ===#
var _size = Vector2(0,0)

var _tile_data = {} # map containing the common data between tiles of a type. _tile_data = { "tile_id": tile_data }
var _tiles = {}  # matches coordinates to a tile's id. Also contains a tile's unique metadata. _tiles = {Vector2: {tile_metadata}


#=== Bootstrap ===#

# Called upon bootstrap.
func initialize(tileset, map_data):
	tile_set = tileset
	_size = map_data.map_size

# Called when the Map Generator has finished generating the map. Binds variables to the Node components.
func startup_components():
	_grid_highlighter = $GridHighlighter
	_grid_highlighter.initialize()
	_tile_highlighter = $TileHighlighter
	_tile_navigator = $TileNavigator
	_tile_navigator.initialize()




#=== Coordinates ===#

# True if a click at a position is within bounds of the tilemap.
func is_pos_valid_tile(pos):
	var coords = local_to_map(pos)
	return is_coords_valid_tile(coords)


# True if coordinates are within bounds of the tilemap.
func is_coords_valid_tile(coords):
	var is_valid = true
	if coords.x < 0 or coords.x > _size.x \
	or coords.y < 0 or coords.y > _size.y:
		is_valid = false
	return is_valid


# Converts a world position into tilemap coordinates.
func pos_to_coords(pos):
	return local_to_map(pos)


# Converts tilemap coordinates into a world position.
func coords_to_pos(coords):
	return map_to_local(coords)


# True if a tile is moveable, assuming the coordinates are valid.
# Takes temporary obstacles into consideration.
func is_tile_moveable(coords): 
	var is_moveable = true
	var tile = _tiles.get(coords)
	if not _tile_data.get(tile["id"])._moveable \
	or tile.get("unmoveable") != null:
		is_moveable = false
	return is_moveable


# True if a tile is moveable, assuming the coordinates are valid.
# Does not take temporary obstacles into consideration.
func is_base_tile_moveable(coords):
	var is_moveable = true
	var tile = _tiles.get(coords)
	if not _tile_data.get(tile.id)._moveable:
		is_moveable = false
	return is_moveable


# Return the "character" on a tile if any is present, assuming the coordinates are valid.
# The "character" can be a player character, enemy character, object, etc.
func get_tile_character(coords):
	var tile = _tiles.get(coords)
	return tile["character"]


# Set the tile at the target coordinates with new data, assuming the coordinates are valid.
func set_tile_at_coords(coords, tile_id_coords, tile_data):
	set_cell(0, coords, 0, tile_id_coords, 0)
	var tile = _tiles.get(coords)
	if tile == null:
		_tiles[coords] = {"id": tile_id_coords} # setup metadata with just the id
	else:
		tile["id"] = tile_id_coords
	var data = _tile_data.get(tile_id_coords)
	if data == null:
		_tile_data[tile_id_coords] = tile_data


# Get the tile's common data, assuming the coordinates are valid.
func get_tile_common_data(coords):
	var tile_common_id = _tiles.get(coords).get("id")
	return _tile_data.get(tile_common_id)


# Get the tile's move cost, assuming the coordinates are valid.
func get_tile_move_cost(coords):
	var tile = _tiles.get(coords)
	var move_cost = _tile_data.get(tile.get("id"))._move_cost
	var meta_move_cost = tile.get("move_cost")
	if meta_move_cost != null:
		move_cost += meta_move_cost
	return move_cost


# Get the tile's enter action, assuming the coordinates are valid.
func get_tile_enter_action(coords):
	var tile = _tiles.get(coords)
	return tile.get("enter_action")




#=== Characters ===#

# Place the character physically at the tilemap's world coordinates.
func place_character_at_coords(character, coords):
#	print("place ", coords)
	var pos = map_to_local(coords)
	character.position = pos


# Remove a character physically from the tilemap's world coordinates.
func remove_character_from_coords(character, coords):
	print("remove ", coords)
	var pos = map_to_local(coords)
	character.position = pos


# Bind the character's data to the tilemap's coordinates.
func bind_character_to_coords(character_id, coords): 
#	print("bind ", coords)
	var tile = _tiles.get(coords)
	tile["character"] = character_id
	tile["unmoveable"] = true


# Unbind the character's data to the tilemap's coordinates.
func unbind_character_from_coords(coords):
#	print("unbind ", coords)
	var tile = _tiles.get(coords)
	var character_id = tile.get("character")
	tile.erase("character")
	tile.erase("unmoveable")
	return character_id


# Set a specific metadata type and value at the tilemap's coordinates.
func set_tile_metadata(coords, metadata_id, value):
	var tile = _tiles.get(coords)
	tile[metadata_id] = value


# Remove a specific metadata type and value from the tilemap's coordinates.
func remove_tile_metadata(coords, metadata_id):
	var tile = _tiles.get(coords)
	tile.erase(metadata_id)




#=== Position ===#

# Return the coordinates at the center of the tilemap.
func calculate_center_coords(): # return the center coordinates in a [from, to] format
	var width_div = _size.x / 2
	var width_mod = int(_size.x) % 2
	var height_div = _size.y / 2
	var height_mod = int(_size.y) % 2
	var center_coords
	if width_mod == 1: # odd width
		if height_mod == 1: # odd height
			center_coords = [Vector2(width_div+1, height_div+1), Vector2(width_div+1, height_div+1)]
		else: # even height
			center_coords = [Vector2(width_div+1, height_div), Vector2(width_div+1, height_div+1)]
	else: # even width
		if height_mod == 1: # odd height
			center_coords = [Vector2(width_div, height_div+1), Vector2(width_div+1, height_div+1)]
		else: # even height
			center_coords = [Vector2(width_div, height_div), Vector2(width_div+1, height_div+1)]
	return center_coords


# Return the position at the center of the tilemap.
func calculate_center_position():
	return (_size * Vector2(64, 64)) / Vector2(2, 2)


# Calculates the starting coordinates for each member of both teams.
func calculate_team_positions():
	var center_x = ceil(_size.x / 2)
	var first_pos = Vector2(center_x -1, 1) 
	var top_team_pos = get_team_pos_based_on_first_pos(first_pos)
	first_pos = Vector2(center_x -1, _size.y - 3)
	var bottom_team_pos = get_team_pos_based_on_first_pos(first_pos)
	return {"top": top_team_pos, "bottom": bottom_team_pos}


# Calculate the positions of the remaining team members via the position of the first.
func get_team_pos_based_on_first_pos(first_pos):
	var team_positions = [first_pos]
	team_positions.append(first_pos + Vector2(2, 0))
	team_positions.append(first_pos + Vector2(0, 2))
	team_positions.append(first_pos + Vector2(2, 2))
	return team_positions




#=== Range ===#

# Return the tiles in range at the center coordinates.
func get_tiles_in_range(coords, radius_range):
	var tiles = []
	for x in range(coords.x-radius_range, coords.x+radius_range):
		for y in range(coords.y-radius_range, coords.y+radius_range):
			tiles.append(_tiles.get(coords))
	return tiles


# Return the characters in range of the center coordinates.
func get_characters_in_range(coords, radius_range):
	var characters = []
	var character
	var tile
	for x in range(coords.x-radius_range, coords.x+radius_range):
		for y in range(coords.y-radius_range, coords.y+radius_range):
			if x == coords.x and y == coords.y:
				continue
			tile = _tiles.get(Vector2(x, y))
			if tile:
				character = tile.get("character")
				if character != null:
					characters.append([character, Vector2(x,y)])
	return characters


# Return the characters in range at the center coordinates.
# Only characters that have a line of sight to the source coords.
#TODO
func get_characters_in_range_with_los(coords, radius_range):
	pass
#	var characters = []
#	var character
#	for x in range(coords.x-radius_range, coords.x+radius_range):
#		for y in range(coords.y-radius_range, coords.y+radius_range):
#			character = _tiles.get(coords).get("character")
#			if character:
#				characters.append(character)
#	return characters



#=== Utils ===#

# Print a tiles information, used in debugging.
func print_tile_info(coords):
	var tile = _tiles.get(coords)
	var data = _tile_data.get(tile.id)
	print( \
		"Tile: ", tile.id,
		"\nCoords: ", coords,
		"\nMoveable: ", is_tile_moveable(coords),
		"\nMove Cost: ", data._move_cost,
		"\nDamage on Enter: ", data._damage_on_enter,
		"\ncharacter: ", tile.get("metadata"),
		"\n",
	)


