#=== About ===#
# This class holds an encounter's information. Itis not included at a node's root.


#=== Variables ===#
var _total_rounds = 0
var _is_player_round = false
#var _victory_rewards


#=== Interaction ===#

func turn_start(is_player_round):
	_total_rounds += 1
	_is_player_round = is_player_round
	return _total_rounds
