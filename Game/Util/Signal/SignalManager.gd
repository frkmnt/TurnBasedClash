extends Node

#=== About ===#
# This autoload singleton registers all available signals that can be emitted. Since they can be accessed from anywhere, 
# other classes can bind events to them without knowledge of the tree hierarchy. These signals can then easily be
# bound in a controller class for dispatch.


#=== Input ===#

signal _on_action_input
signal _on_mouse_input
signal _on_mouse_motion


#=== Round Management ===#

signal _on_game_start_announcement_finished
signal _on_round_announcement_finished
signal _on_pass_turn


#=== Player Management ===#

signal _on_character_moved
signal _on_character_finished_moving
