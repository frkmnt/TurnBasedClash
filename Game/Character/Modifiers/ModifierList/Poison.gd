extends Node

const max_active_turns = 2
const _types = ["turn_end"]
var _parent_class

var needs_to_be_removed = false
var active_turns = 0

var damage = 15

func initialize(parent_class):
	_parent_class = parent_class



func on_turn_end():
	_parent_class._attributes.subtract_health(damage)
	active_turns += 1
	if active_turns >= max_active_turns:
		needs_to_be_removed = true


func remove():
	queue_free()
