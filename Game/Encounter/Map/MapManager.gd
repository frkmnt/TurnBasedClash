extends Node2D

#=== About ===#
# Manages anything related to the encounter's playable map.


#=== References ===#
var _parent

#=== Components ===#
var _tilemap

#=== Variables ===#
var _character_coords = {} # matches a character_id to its tilemap coordinates

# All the tiles the character can currently move to.
# TODO This is calculated at turn start.
var _moveable_tiles = []

# The currently selected path. All tiles must be included in _moveable_tiles.
var _selected_path = []




# ===Bootstrap===

# Bootstrap this class. Called by the EncounterManager.
func initialize(tilemap):
	_parent = get_parent()
	_tilemap = tilemap
	add_child(_tilemap)


# Places the teams at their initial positions, by calculating valid tiles for each character.
# TODO This is called by the EncounterManager upon bootstrap. Extract to this class. 
func place_teams(character_data):
	var positions = _tilemap.calculate_team_positions()
	var bottom_positions = positions.get("bottom")
	var top_positions = positions.get("top")
	
	var data
	var coords
	for character_id in character_data.keys():
		data = character_data.get(character_id)
		if data.get("team_id") == "blue":
			coords = bottom_positions.pop_front()
		else:
			coords = top_positions.pop_front()
		_tilemap.place_character_at_coords(data.get("character"), coords)
		_tilemap.bind_character_to_coords(character_id, coords)
		_character_coords[character_id] = coords
	
#	place_blue_team(teams["blue"], coords[0])




#=== Highlight Management ===#

# Removes all active highlights.
func remove_all_highlights():
	_tilemap._tile_highlighter.remove_all_highlights()


# create a highlight at the target coordinates of a specific color.
func create_highlight_at_coords(coords, color_id):
	_tilemap._tile_highlighter.place_highlight_on_tile( _tilemap.coords_to_pos(coords), coords, color_id)


# Remove the highlight from the target coordinates.
func remove_highlight_at_coords(coords):
	_tilemap._tile_highlighter.remove_highlight_at_coords(coords)


# Highlight all the tiles present in _moveable_tiles.
func highlight_moveable_tiles():
	for tile_coords in _moveable_tiles:
		create_highlight_at_coords(tile_coords, "moveable_tiles")


# Remove the highlights all the tiles present in _moveable_tiles.
func remove_highlight_from_moveable_tiles():
	for tile_coords in _moveable_tiles:
		remove_highlight_at_coords(tile_coords)


# Highlight all the tiles in the currently seleted path.
func highlight_selected_path(color_id):
	var path = get_selected_path_without_character_pos()
	for coords in path: # ignore character position
		create_highlight_at_coords(coords, color_id)


# Remove the highlight from all the tiles in the currently seleted path.
func remove_highlight_from_selected_path():
	var path = get_selected_path_without_character_pos()
	for coords in path: # ignore character position
		remove_highlight_at_coords(coords)


# Highlight the tile where the current character is.
func highlight_current_character(char_id, is_ally):
	var current_character_coords = _character_coords.get(char_id)
	if is_ally:
		create_highlight_at_coords(current_character_coords, "cur_ally")
	else:
		create_highlight_at_coords(current_character_coords, "cur_enemy")


# Remove the highlight from the tile where the current character is.
func remove_highlight_from_character(char_id):
	var current_character_coords = _character_coords.get(char_id)
	remove_highlight_at_coords(current_character_coords)




#=== Interaction Management ===#

# Handles a click in camera mode.
# TODO Currently does nothing.
func clicked_in_camera_mode():
	var coords = validate_click_pos_to_coordinates()
	if coords == null:
		return


# Triggered when a player has clicked a tile in move move.
# If a valid path is selected, it is placed in _selected_tiles.
# If the destination of the selected tiles path is clicked, the player moves to the destination.
func clicked_in_move_mode(coords, character_id, cur_speed):
	if _character_coords.get(character_id) == coords:
		return
	var is_path_selected =  _selected_path.size() > 1
	if is_path_selected:
		var destination = _selected_path[_selected_path.size()-1] # TODO add a condition if the click is in the selected path but not the destination
		if destination == coords: # confirmed a click on the selected path
			remove_highlight_from_moveable_tiles()
			remove_highlight_from_selected_path()
			move_character_along_path(coords, character_id, cur_speed)
		elif not _moveable_tiles.has(coords): # clicked outside moveable bounds TODO should this deselect the selected path?
			highlight_selected_path("moveable_tiles")
			_selected_path.clear()
		else: # clicked a tile that is moveable but not in the selected path
			highlight_selected_path("moveable_tiles")
			calculate_selected_path_for_character(coords, character_id, cur_speed)
			highlight_selected_path("selected_path")
			return
	else: # clicked moveable tile while no path was selected
		calculate_selected_path_for_character(coords, character_id, cur_speed)
		highlight_selected_path("selected_path")




#=== Navigation ===#

# Calculates the moveable tiles for a character based on their speed, and updates _moveable_tiles.
# This is a square of radius speed around the character.
func calculate_moveable_tiles(coords, speed):
	_moveable_tiles.clear()
	var tile_navigator = _tilemap._tile_navigator
	_moveable_tiles = tile_navigator.get_moveable_tiles(coords, speed)


# Calculates the path to a player-selected moveable tile, then updates _selected_path.
func calculate_selected_path_for_character(coords, character_id, cur_speed):
	var character_coords = _character_coords[character_id]
	var path_info = _tilemap._tile_navigator.get_astar_path_info(character_coords, coords, cur_speed)
	_selected_path = path_info.get("path")


# Calculates the path to a character, optimizes it and then returns the path and speed cost.
# This is generally used by enemies that want to pathfind to another character.
func calculate_path_to_character(coords, character_id, cur_speed):
	var character_coords = _character_coords[character_id]
	var path_info = _tilemap._tile_navigator.get_astar_enemy_info(character_coords, coords, cur_speed)
	var calculated_path = path_info.get("path")
	var speed_cost = path_info.get("cost")
	var path = simulate_character_movement(calculated_path)
	var clamped_path = clamp_path(path)
	_tilemap.unbind_character_from_coords(character_coords)
	_tilemap.bind_character_to_coords(character_id, _character_coords[character_id])
	return [clamped_path, speed_cost]


# Validates the path to a tile, optimizes it and then returns the path.
# This is used by players when confirming a selected moveable tile.
func move_character_along_path(dest_coords, character_id, cur_speed):
	var character_coords = _character_coords[character_id]
	var path_info = _tilemap._tile_navigator.get_astar_path_info(character_coords, dest_coords, cur_speed)
	_selected_path = path_info.get("path")
	var speed_cost = path_info.get("cost")
	var path = simulate_character_movement(_selected_path)
	var clamped_path = clamp_path(path)
	if clamped_path.size() == 0:
		return
	remove_highlight_at_coords(_selected_path[0])
	_character_coords[character_id] = _selected_path.pop_back()
	_tilemap.unbind_character_from_coords(character_coords)
	_tilemap.bind_character_to_coords(character_id, _character_coords[character_id])
	SignalManager.emit_signal("_on_character_moved", [character_id, clamped_path, speed_cost])
	_selected_path.clear()


# Simulates the character's movement, stopping if any obstacle is encountered.
# The path is returned with the updated/validated destination.
# Returns an empty array in case of an error.
# TODO update speed
func simulate_character_movement(path): # returns a list of positions in the path
	var new_path = []
	if path.size() > 0:
		for coords in path:
			new_path.append(coords)
			if _tilemap.get_tile_enter_action(coords) != null:
				break # TODO check if character is immune
	return new_path


# Clamps a path, by joining all separate movement vectors in the same direction into a single vector.
func clamp_path(path):
	var clamped_path = []
	if path.size() > 2:
		var last_offset = path[1] - path[0]
		path.pop_front()
		for i in range(0, path.size() - 1):
			if path[i + 1] - path[i] != last_offset:
				last_offset = path[i + 1] - path[i]
				clamped_path.append(_tilemap.coords_to_pos(path[i]))
		clamped_path.append(_tilemap.coords_to_pos(path[path.size() - 1])) # last pos
	elif path.size() > 1: # the path is guaranteed to be at least 2: [initial_pos, dest]
		clamped_path.append(_tilemap.coords_to_pos(path[1]))
	return clamped_path




#=== Tile Search ===#

# Get all characters in the range of radius, centered at coords. 
func get_characters_in_range(coords, radius_range):
	return _tilemap.get_characters_in_range(coords, radius_range)


# Calculates the player characters closest to the position a coords.
# In case of a tie, returns all the tied heroes.
func calculate_nearest_heroes(coords, character_ids):
	var hero_coords_data = get_characters_coords(character_ids) # [hero_id, coords] 
	var nearest_data = []
	var nearest_distance = 9999
	var cur_distance
	for hero_data in hero_coords_data:
		cur_distance = calculate_distance_between_coords(coords, hero_data[1])
		if cur_distance < nearest_distance:
			nearest_data.append(hero_data)
			nearest_distance = cur_distance
	return nearest_data




#=== Utils ===#

# returns null if invalid
func validate_click_pos_to_coordinates():
	var pos = get_global_mouse_position()
	if not _tilemap.is_pos_valid_tile(pos):
		return null
	var new_pos = _tilemap.pos_to_coords(pos)
	var coords = Vector2(new_pos.x, new_pos.y)
	return coords

func get_character_coords(char_id):
	return _character_coords.get(char_id)

func get_characters_coords(character_ids):
	var hero_coords = []
	for char_id in character_ids:
		hero_coords.append([char_id, _character_coords.get(char_id)]) # array of [char_id, coords]
	return hero_coords


func get_selected_path_without_character_pos():
	return _selected_path.slice(1)



func calculate_distance_between_coords(coords, dest_coords):
	var x_dist = abs(coords.x - dest_coords.x)
	var y_dist = abs(coords.y - dest_coords.y)
	return x_dist + y_dist
