extends Node

#=== About ===#
# This class generates an astar structure containing the tiles inside the map. It can be consulted for information regarding movement costs, etc.
# TODO optimize not to use the built in astar, since the weight cannot be set in the edges but on the points. This results in being unable to set preference
# between vertical/horizontal and diagonal movements. This causes janky pathfinding.


#=== References ===#
var _parent

#=== Signals ===#
signal _character_reached_destination

#=== Constants ===#
const _navigation_propagations = [Vector2(0,-1), Vector2(0,1), Vector2(1,0), Vector2(-1,0), Vector2(1,-1), Vector2(1,1), Vector2(-1,1), Vector2(-1,-1)]

#=== Variables ===#
var _map_height
var _astar


#=== Bootstrap ===#

func initialize():
	_parent = get_parent()
	_map_height = _parent._size.y
	_astar = AStar2D.new()
	load_astar_points()
	load_astar_connections()


func load_astar_points():
	var tile_astar_id
	for tile_coords in _parent._tiles.keys():
		if not _parent.is_base_tile_moveable(tile_coords):
			continue
		tile_astar_id = coordinates_to_id(tile_coords)
		_astar.add_point(tile_astar_id, tile_coords, 1)

func load_astar_connections(): 
	var coords
	for point_id in _astar.get_point_ids():
		coords = _astar.get_point_position(point_id)
		var propagation_id
		for propagation_direction in _navigation_propagations:
			propagation_id = coordinates_to_id(coords + propagation_direction)
			if _astar.has_point(propagation_id) \
			and not _astar.are_points_connected(point_id, propagation_id) \
			and _parent.is_coords_valid_tile(coords):
				_astar.connect_points(point_id, propagation_id, true)



#=== Astar Pathfinding ===#

var _astar_path = [] # contains items of type {path:[tiles], cost:int, estimate:int}
var _dest_coords
var _speed


# Standard Astar pathfinding for character > tile.
# Makes the origin tile temporarily moveable to allow navigation.
# Returns the shortest path or closest point in the case of insufficient speed.
func get_astar_path_info(coords, dest_coords, speed):
	var was_unmoveable = _parent._tiles.get(coords).erase("unmoveable")
	_speed = speed
	_dest_coords = Vector2(dest_coords.x, dest_coords.y)
	# calculate the path
	var cur_path = {"path":[coords], "cost":0, "estimate":get_distance_estimate(coords, dest_coords)}
	_astar_path.append(cur_path)
	var path_data = astar_path_recursive()
	# reverse unmoveable setting for origin tile
	if was_unmoveable:
		_parent._tiles.get(coords)["unmoveable"] = true
	_astar_path.clear()
	path_data.erase("estimate")
	# tidy up the path
	var tile_path = path_data.get("path")
	tile_path.reverse()
	path_data["path"] = tile_path
	return path_data


# Astar pathfinding for character > character.
# It is used to allow enemies to pathfind to other characters, since
# both the origin and destination tiles need to be set to moveable to allow navigation.
# Returns the shortest path to an adjacent tile or closest point in the case of insufficient speed.
func get_astar_enemy_info(coords, dest_coords, speed): 
	var was_unmoveable_origin = _parent._tiles.get(coords).erase("unmoveable")
	var was_unmoveable_destination = _parent._tiles.get(dest_coords).erase("unmoveable")
	_speed = speed
	_dest_coords = Vector2(dest_coords.x, dest_coords.y)
	# calculate the path
	var cur_path = {"path":[coords], "cost":0, "estimate":get_distance_estimate(coords, dest_coords)}
	_astar_path.append(cur_path)
	var path_data = astar_path_recursive()
	# reverse unmoveable setting for origin tile
	if was_unmoveable_origin:
		_parent._tiles.get(coords)["unmoveable"] = true
	if was_unmoveable_destination:
		_parent._tiles.get(coords)["unmoveable"] = true
	_astar_path.clear()
	path_data.erase("estimate")
	# tidy up the path, erase the tail if == destination, since there is a character there
	var tile_path = path_data.get("path")
	if tile_path[0] == dest_coords:
		tile_path.pop_front()
		path_data["cost"] -= 1
	tile_path.reverse()
	path_data["path"] = tile_path
	return path_data


func astar_path_recursive():
	var cur_path = _astar_path[0] # first instance is always the shortest path currently available
	var cur_coords = cur_path["path"][0] # the coordinates at the head of the list are the current position
	var cur_cost = cur_path["cost"]
	if cur_coords == _dest_coords or _speed - cur_path["cost"] <= 0 : # base case
		return cur_path
	
	var propagatable_tiles = get_propagatable_tiles(cur_coords)
	var propagation_path
	var propagation_cost
	var propagation_estimate
	for prop_coords in propagatable_tiles:
		propagation_path = cur_path["path"].duplicate(true)
		propagation_path.push_front(prop_coords)
		propagation_cost = cur_cost + _parent.get_tile_move_cost(prop_coords)
		propagation_estimate = get_distance_estimate(prop_coords, _dest_coords)
		_astar_path.append({"path":propagation_path, "cost":propagation_cost, "estimate": propagation_estimate})
	_astar_path = _astar_path.slice(1)
	_astar_path.sort_custom(sort_astar_paths)
	cur_path = astar_path_recursive()
	return cur_path




#=== Astar Utils ===#

# Retuns the tiles to which you can navigate to from the current coordinates.
# Ignores tiles that cannot be navigated to, but they can be temporarily overwritten
# by the root Astar function.
func get_propagatable_tiles(coords):
	var propagatable_tiles = []
	var propagation_coords
	var propagation_id
	for propagation_direction in _navigation_propagations:
		propagation_coords = coords + propagation_direction
		propagation_id = coordinates_to_id(propagation_coords)
		if _astar.has_point(propagation_id) \
		and _parent.is_tile_moveable(propagation_coords):
			propagatable_tiles.append(propagation_coords)
	return propagatable_tiles


# Returns the distance between 2 points as the Astar estimate.
func get_distance_estimate(coords, dest_coords):
	var x_dist = abs(coords.x - dest_coords.x)
	var y_dist = abs(coords.y - dest_coords.y)
	return x_dist + y_dist


# Sorts the paths by calculating the weight of the path, 
# which is the cost of travelling + the distance estimate.
func sort_astar_paths(path_a, path_b):
	var is_smaller = false
	var cost_a = path_a["cost"] + path_a["estimate"]
	var cost_b = path_b["cost"] + path_b["estimate"]
	if cost_a < cost_b:
		is_smaller = true
	return is_smaller





#=== Moveable Tiles ===#

var _moveable_tiles = {}

func get_moveable_tiles(coords, speed):
	var was_unmoveable = _parent._tiles.get(coords).erase("unmoveable")
	var coords_id = coordinates_to_id(coords)
	calculate_moveable_tiles_recursive(coords_id, speed+1)
	if was_unmoveable:
		_parent._tiles.get(coords)["unmoveable"] = true
	
	var moveable_coords = []
	var aux_coords
	for point_id in _moveable_tiles:
		aux_coords = _astar.get_point_position(point_id)
		if not moveable_coords.has(aux_coords): # TODO test speed
			moveable_coords.append(Vector2(aux_coords.x, aux_coords.y))
	if moveable_coords.size() > 0:
		moveable_coords = moveable_coords.slice(1)
	_moveable_tiles.clear()
	return moveable_coords

func calculate_moveable_tiles_recursive(coords_id, speed):
	if _moveable_tiles.has(coords_id) and _moveable_tiles[coords_id] >= speed:
		return
	if speed <= 0 or not _parent.is_tile_moveable(_astar.get_point_position(coords_id)):
		return
	var prev_tile_speed = _moveable_tiles.get(coords_id)
	if prev_tile_speed != null and prev_tile_speed > speed:
		return
	
	_moveable_tiles[coords_id] = speed
	var connections = _astar.get_point_connections(coords_id)
	for connection in connections:
		calculate_moveable_tiles_recursive(connection, speed-_parent.get_tile_move_cost(_astar.get_point_position(connection )))
	return





#=== Utils ===#

func coordinates_to_id(coords): # works as a checksum
	return int((coords.x * _map_height) + coords.y)

