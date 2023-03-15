#=== About ===#
# This class holds an encounter's information. Itis not included at a node's root.


#=== Variables ===#
var _total_rounds = 0
#var _victory_rewards


#=== Interaction ===#

func turn_start():
	_total_rounds += 1
	return _total_rounds
