extends Camera2D

#=== About ===#
# This class handles all camera related actions. It is called from the EncounterCombatParser, and translates the calls into
# valid camera actions.



#=== Signals ===#
signal input_pressed

#=== Constants ===#
const _ZOOM_TWEEN_DURATION = 0.1
const _ZOOM_INCREMENT = 0.25
const _MIN_ZOOM = 1
const _MAX_ZOOM = 3





#=== Zoom ===#

func on_zoom_in():
	var new_zoom = get_zoom().x
	new_zoom += _ZOOM_INCREMENT
	if new_zoom >= _MAX_ZOOM:
		new_zoom = _MAX_ZOOM
	tween_zoom(Vector2(new_zoom, new_zoom))
	
func on_zoom_out():
	var new_zoom = get_zoom().x
	new_zoom -= _ZOOM_INCREMENT
	if new_zoom <= _MIN_ZOOM:
		new_zoom = _MIN_ZOOM
	tween_zoom(Vector2(new_zoom, new_zoom))


func set_new_position(drag_vector):
	var drag_proportion = (Vector2(1, 1) / get_zoom()) # to ensure drag is uniform throughout zoom levels
	drag_vector *= -1 * drag_proportion
	position = position + drag_vector


#=== Utils ===#

func tween_zoom(new_zoom):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "zoom", new_zoom, _ZOOM_TWEEN_DURATION)



