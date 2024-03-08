extends Node2D

#=== About ===#
# This class acts as an agnostic handler for character animations.
#TODO update this class description
# It takes a _cur_anim_func and a _cur_anim_data parameters, that allow animations
# to seamlessly implement different logic.



#=== Components ===#
var _anim_player 
var _sprite
var _character

#=== Cosntants ===#
const _move_speed = 250

#=== Variables ===#
# an array of animation (a map). The contents vary depending on the animation.
# Simple anims contain "is_simple=true", "anim_id" and "should_loop".
# A Data anim contain "is_simple=false", "anim_id", "should_process", "anim_func" and "anim_data".
var _cur_anim_queue = []
# The function (if any) assigned to the current data animation. Allows direct memory access.
var _cur_anim_func = ""
# The data (if any) assigned to the current data animation. Allows direct memory access.
var _cur_anim_data = {}



#=== Bootstrap ===#

# Referenced when the Animator is generated.
func _ready():
	_anim_player = $AnimationPlayer
	_sprite = $Sprite2D
	set_process(false)
	_character = get_parent()



#=== Process ===

func _process(delta):
	if _cur_anim_func != null: # _cur_anim_func
		_cur_anim_func.call(delta)




#=== Mode Management ===#

# This function handles the movement to position animation.
# THe anim data contains 
func process_move_to_pos(delta): # _cur_anim_data is an array of positions
	if _cur_anim_data.size() <= 0: # target has reached destination, ie anim is finished
		set_process(false)
		advance_to_next_anim()
	else: # movement logic
		var dest_pos = _cur_anim_data[0]
		var cur_pos = _character.global_position
		if cur_pos - Vector2(dest_pos) != Vector2(0, 0): # TODO remove Vector2 casting
			_character.global_position = cur_pos.move_toward(dest_pos, _move_speed * delta)
		else:
			_cur_anim_data.pop_front()


# Emits a log. _cur_anim_data is the log message.
func emit_log():
	SignalManager.emit_signal("_on_register_log", _cur_anim_data)
	advance_to_next_anim()


# Emits a signal. _cur_anim_data is [signal_id, signal_data]
func signal_animation():
	var data = _cur_anim_data[1]
	if data != null:
		SignalManager.emit_signal(_cur_anim_data[0], _cur_anim_data[1])
	else:
		SignalManager.emit_signal(_cur_anim_data[0])
	advance_to_next_anim()


# Called when all the animations in the queue have finished.
# _cur_anim_data is the signal that needs to be emitted.
func on_animation_queue_finished():
	_cur_anim_queue = []
	_cur_anim_func = ""
	var signal_to_emit = _cur_anim_data
	_cur_anim_data = {}
	SignalManager.emit_signal(signal_to_emit)




#=== Animation Interface ===#

# Used for animations that require data and/or process updates
func queue_data_anim(anim_id, anim_data):
	bind_data_anim(anim_id, anim_data)


# Animations that don't require external processing
func queue_simple_anim(anim_id, should_loop):
	bind_simple_anim(anim_id, should_loop)






#=== Queue Execution ===#

func play_simple_anim(anim_id):
	_anim_player.play(anim_id)


func play_anim_queue(signal_when_finished):
	bind_data_anim("finish_animating", signal_when_finished) # add the final animation
	start_animation(_cur_anim_queue[0])


# Start playing an animation. This applies different logic if the animation is simple or data.
func start_animation(anim):
	var anim_id = anim.get("anim_id")
	if _anim_player.has_animation(anim_id):
		_anim_player.play(anim_id)
	if anim.get("is_simple") == true: # simple animation
		if anim.get("should_loop"): # animation is infinite, advance to next step.
			advance_to_next_anim()
	else: # data animation
		_cur_anim_func = anim.get("anim_func")
		_cur_anim_data = anim.get("anim_data")
		var should_process = anim.get("should_process")
		if should_process:
			set_process(true)
		else:
			_cur_anim_func.call()
#finish_animating

# Called when an animation has finished. This moves on to the next animation queued.
func advance_to_next_anim():
	var cur_anim = _cur_anim_queue.pop_front()
	if _cur_anim_queue.size() > 0:
		var next_anim = _cur_anim_queue[0]
		start_animation(next_anim)


#TODO implement
# Called when a non-looping animtion finishes. Checks if there is an ongoing queue,
# and invokes the next animation if so.
func on_animation_finished(anim_id):
	if _cur_anim_queue.size() > 1:
		var cur_anim = _cur_anim_queue.pop_front()
		var next_anim = _cur_anim_queue[0]
		start_animation(next_anim)
	elif _cur_anim_queue.size() == 1: # this is the last anim
		_cur_anim_queue.clear()







#=== Utils ===#

func bind_data_anim(anim_id, anim_data):
	var function_details = match_anim_id_to_function(anim_id) # [should_process, corresponding_func]
	var animation = {
		"is_simple": false,
		"anim_id": anim_id,
		"should_process": function_details[0],
		"anim_func": function_details[1],
		"anim_data": anim_data,
	}
	_cur_anim_queue.append(animation)


func bind_simple_anim(anim_id, should_loop):
	var animation = {
		"is_simple": true,
		"anim_id": anim_id,
		"should_loop": should_loop
	}
	_cur_anim_queue.append(animation)



func match_anim_id_to_function(anim_id):
	var should_process = false
	var corresponding_func
	match anim_id:
		"move":
			should_process = true
			corresponding_func = process_move_to_pos
		"finish_animating":
			should_process = false
			corresponding_func = on_animation_queue_finished
		"log":
			should_process = false
			corresponding_func = emit_log
		"signal":
			should_process = false
			corresponding_func = signal_animation
	return [should_process, corresponding_func]





