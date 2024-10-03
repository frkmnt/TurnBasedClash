extends Node

# _damage_types_range, _damage_min_range and _damage_max_range are merged
# when creating a new weapon, resulting in a map like {"damage_type": [min_dmg, max_dmg]}


#=== Parameters ===#

const _name = "Wood"

var _rarity_weight = 70 # weight out of the total sum of the rarity weights
var _targeting_types_ranges = [[98, 1], [8, 2]] # The chance to have 1/more targeting types
var _damage_types_range = [[95, 1], [8, 2]] # The chance to have 1/more damage types
var _damage_min_range = [[10, [5, 8]], [25, [9, 13]], [25, [14, 19]], [10, [20, 23]]]
var _damage_max_range = [[20, [1, 3]], [50, [4, 7]], [10, [8, 9]]] # added to the min value
var _nr_of_mods_range = 10 #TODO 
var _expiration_range = [3, 5] # expires after 1-5 raids/uses?
