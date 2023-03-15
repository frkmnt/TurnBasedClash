extends Label

#=== About ===#
# A generic annoucement Label. It can be animated differently depending on the occasion (see the Bootstrap category).


#=== Bootstrap ===#

func initialize_in_game_start_mode():
	text = "Battle Start"

func initialize_in_round_mode(round_num):
	text = "Round " + str(round_num)


#=== Utils ===#

func get_center_coords():
	var coords = get_viewport_rect().size - get_combined_minimum_size()
	return coords / 2
