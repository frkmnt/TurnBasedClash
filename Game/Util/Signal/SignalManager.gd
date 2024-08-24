extends Node

#=== About ===#
# This autoload singleton registers all available signals that can be emitted. Since they can be accessed from anywhere, 
# other classes can bind events to them without knowledge of the tree hierarchy. These signals can then easily be
# bound in a controller class for dispatch.
# Signals can be emitted from anywhere via SignalManager.emit_signal("_signal_name")


#=== Input ===#

signal _on_action_input
signal _on_mouse_input
signal _on_mouse_motion


#=== Round Management ===#

signal _on_game_start_announcement_finished
signal _on_turn_announcement_finished
signal _on_pass_turn


#=== Map Management ===#
signal _highlight_current_character
signal _highlight_tiles #TODO unused
signal _remove_highlight_from_tiles


#=== Skill Management ===#
signal _on_skill_selected

#=== Bag Management ===#
signal _on_bag_selected


#=== Character Management ===#
signal _on_player_character_moved
signal _on_player_character_finished_moving


#=== UI Management ===#
signal _on_register_log
signal _update_all_input_locks # receives 2 "is_locked" bools: for input and the camera respectively.
signal _on_button_pressed # receives the button_id as a parameter
