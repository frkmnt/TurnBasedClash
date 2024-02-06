extends Node2D

#=== About ===#
# Handles the grid highlighting. Added directly as a child of the tilemap, it is only instanced by the tilemap when all its tile data is set. 
# TODO try to implement draw_polylien instead of draw_line
# TODO optimize add the repetitive calculations in draw to variables calculated during initialize


#=== Constants ===#
const _color = Color(255, 69, 0, 0.4)
const _line_width = 2


#=== Variables ===#
var _tilemap_grid_size
var _tile_size


#=== Bootstrap ===#

func initialize():
	var parent = get_parent()
	_tile_size = parent.get_quadrant_size()
	_tilemap_grid_size = parent.get_used_rect()



#=== Update ===#

func _process(_delta):
	update()


func _draw():
	for x in range(1, _tilemap_grid_size.size.x):
		draw_line(
			Vector2(x * _tile_size, _tile_size), 
			Vector2(x * _tile_size, (_tilemap_grid_size.size.y-1) * _tile_size), 
			_color, _line_width, true)

	for y in range(1, _tilemap_grid_size.size.y):
		draw_line(
			Vector2(_tile_size, y * _tile_size), 
			Vector2((_tilemap_grid_size.size.x-1) * _tile_size, y * _tile_size), 
			_color, _line_width, true)
