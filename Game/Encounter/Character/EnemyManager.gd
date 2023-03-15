extends Node

#=== About ===#
# An API that provides abstraction for the common behaviours of enemy characters. 



#=== References ===#
var _character_manager
var _map_manager



#=== Bootstrap ===#

func initialize(parent):
	_character_manager = parent._character_manager
	_map_manager = parent._map_manager



#=== Find Target ===#





func find_nearest_hero_in_radius(position, radius): # returns the nearest heroes inside a radius. In case of a tie, returns all the heroes.
	pass

