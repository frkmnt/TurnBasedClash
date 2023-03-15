extends Node2D

#=== About ===#
# Handles tile highlighting and its animations. Also handles the pathfinding line drawn for convinience.



#=== Prefabs ===#
const _tile_highlight_prefab = preload("res://Encounter/Map/Tiles/TileHighlight.tscn")

#=== Constants ===#
const _alpha_increment = 1.5
const _starting_alpha = 0.75

const _current_ally = Color(4, 108, 0)
const _current_enemy = Color(110, 29, 36)
const _team_color = Color(0, 255, 0)
const _enemy_color = Color(255, 0, 0)
const _moveable_tiles_color = Color(0, 20, 255)
const _selected_path_color = Color(255, 0, 255)

#=== Variables ===#
var _highlight_coords = {} # maps tile coordinates to the corresponding highlights.
var _is_animating = false
var _cur_alpha = _starting_alpha
var _direction = 1 # determines whether the alpha increases/decreases


#=== Bootstrap ===#

func _ready():
	pass



#=== Highlight Management ===#

func place_highlight_on_tile(pos, coords, color_id):
	var color = match_id_to_color(color_id)
	color.a = _cur_alpha
	if _highlight_coords.has(coords):
		_highlight_coords.get(coords).update_color(color)
		return
	var highlight = _tile_highlight_prefab.instantiate()
	highlight.initialize(pos, color)
	_highlight_coords[coords] = highlight
	add_child(highlight)
	handle_anim_timer_on_place()


func remove_highlight_at_coords(coords):
	if not _highlight_coords.has(coords):
		return
	_highlight_coords.get(coords).queue_free()
	_highlight_coords.erase(coords)
	if _highlight_coords.size() == 0:
		reset_timer()

func remove_all_highlights():
	_highlight_coords.clear()
	for child in get_children():
		child.queue_free()
	reset_timer()



#=== Timer Management ===#

func handle_anim_timer_on_place():
	if not _is_animating:
		_is_animating = true
		_cur_alpha = _starting_alpha
		_direction = 1


func reset_timer():
	_is_animating = false
	_cur_alpha = _starting_alpha
	_direction = 1



#=== Update ===#

func _process(delta):
	if not _is_animating:
		return
	_cur_alpha = handle_alpha_increment(delta)
	for highlight in _highlight_coords.values():
		highlight.update_alpha(_cur_alpha)


#=== Utils ===#

func handle_alpha_increment(delta):
	var new_alpha = (_cur_alpha + (_alpha_increment * _direction * delta)) 
	if new_alpha <= 0 or new_alpha >= 1:
		_direction *= -1
	return clamp(new_alpha, 0, 1)

func match_id_to_color(color_id):
	var color = _team_color
	match color_id:
		"cur_ally":
			color = _current_ally
		"cur_enemy":
			color = _current_enemy
		"team":
			color = _team_color
		"enemy":
			color = _enemy_color
		"moveable_tiles":
			color = _moveable_tiles_color
		"selected_path":
			color = _selected_path_color
	return color

