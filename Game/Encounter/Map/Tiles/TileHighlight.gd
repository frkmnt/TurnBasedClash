extends Sprite2D

#=== About ===#
# A tile highlight that fades in/out. Managed by the TileHighlighter.


#=== Variables ===#
var _color



#=== Bootstrap ===#

func initialize(pos, color):
	position = pos
	_color = color
	set_self_modulate(_color)



#=== Color Management ===#

func update_color(new_color):
	set_self_modulate(new_color)

func update_alpha(new_alpha):
	var new_color = get_self_modulate()
	new_color.a = new_alpha
	set_self_modulate(new_color)
