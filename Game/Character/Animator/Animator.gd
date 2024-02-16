extends Node2D

#=== About ===#
# This class acts as an agnostic handler for character animations.

#=== Components ===#
var _anim_player 
var _sprite
var _character

#=== Cosntants ===#
const _move_speed = 250

#=== Variables ===#
var _cur_anim_func
var _cur_anim_data

#=== Bootstrap ===#

# Referenced when the Animator is generated.
func _ready():
	_anim_player = $AnimationPlayer
	_sprite = $Sprite2D
	set_process(false)
	_character = get_parent()



#=== Process ===

func _process(delta):
	if _cur_anim_func != null:
		_cur_anim_func.call(delta)



#=== Mode Management ===#

func process_move_to_pos(delta): # _cur_anim_data is an array of positions
	if _cur_anim_data.size() <= 0:
		set_process(false)
		_character.on_finished_moving()
		return 
	var dest_pos = _cur_anim_data[0]
	if global_position - Vector2(dest_pos) != Vector2(0, 0): # TODO remove Vector2 casting
		global_position = global_position.move_toward(dest_pos, _move_speed * delta)
	else:
		_cur_anim_data.pop_front()




#=== Animation Interface ===#

# Used for animations that require data and/or process updates
func play_data_anim(anim_id, anim_data):
	bind_anim_data(anim_id, anim_data)
	_anim_player.play(anim_id)


# Animations that don't require external processing
func play_simple_anim(anim_id):
	_anim_player.play(anim_id)


# Testing function for enemies without animations.
func play_data_anim_no_anim(anim_id, anim_data):
	bind_anim_data(anim_id, anim_data)




#=== Utils ===#

func bind_anim_data(anim_id, anim_data):
	_cur_anim_data = anim_data
	var function_details = match_anim_id_to_function(anim_id)
	set_process(function_details[0])
	_cur_anim_func = function_details[1]


func match_anim_id_to_function(anim_id):
	var should_process = false
	var corresponding_func
	match anim_id:
		"move":
			should_process = true
			corresponding_func = process_move_to_pos
	return [should_process, corresponding_func]


