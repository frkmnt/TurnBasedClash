extends Resource

# X represents the player, at relative (0,0) coordinates
# 1 are full damage tiles (damage * 1/1)
# 1/2 are half damage tiles (damage * 1/2)
# 1/3 are half damage tiles (damage * 1/3),
# 3/5 are three-fifths damage tiles (damage * 3/3), etc.
# - are non targetable tiles, not included in the array

# In this case, 2 represents 1/2 damage.
#- - - - -
#- 1 2 1 -
#- 2 X 2 -
#- 1 2 1 -
#- - - - -

var _name = "Sword"

# Each entry in tiles corresponds to an array of [targettable_coords, damage_amount]
var _targetable_tiles = \
	[
		[[0,-1], 1/2],
		[[0,1], 1/2], 
		[[-1,0], 1/2], 
		[[1,0], 1/2], 
		[[-1,-1], 1], 
		[[-1,1], 1], 
		[[1,-1], 1], 
		[[1,1], 1],
	]
