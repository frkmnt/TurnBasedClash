extends Node

#==== Class Comments ====#
# This class handles all weapon and weapon related generation.

#TODO the generation ranges logic could be abstracted to a component
#TODO the values inside the rarity data classes could be calculated ahead of time




#==== Prefabs ====#
const _weapon_prefab = preload("res://Encounter/Generator/Gear/Weapons/Weapon.gd")


#==== Variables ====#

# [(rarity_value, "type")]
# Each entry corresponds to the rarity weight and corresponding 
# data struct, eg [(70, {wood_rarity_data...}), (20, iron_rarity_data)] 
# Then, the rarities are added sequentially, 
# resulting in _rarity_ranges -> [[(70, {wood_rarity_data}), (90, {iron_rarity_data})]
# When adding new rarities, just add a new rarity class to the Rarity folder, 
# and the range is automatically calculated based on its weight.
var _rarity_ranges = []

# {targeting_id: targeting_data}
var _targeting_types = {}



#=== Bootstrap ===#

func _ready():
	generate_rarity_ranges()
	load_targeting_types()
	
	var lowest_range = [0, 0]
	var highest_range = [10000, 10000]
	for i in range(0,100):
		var weapon = generate_random_weapon()



# Automatically crawl the rarity folder and add all the relevant
# rarity data for each tier.
func generate_rarity_ranges():
	var directory_path = "res://Encounter/Generator/Gear/Weapons/Rarity"
	var rarity_data
	var total_range = 0
	
	for file_name in DirAccess.get_files_at(directory_path): # iterate rarity classes
		rarity_data = load(directory_path + "/" + file_name)
		total_range = add_rarity_range(rarity_data.new(), total_range)


# Add the entry to _rarity_ranges, incrementing the total_range
# based on the previous total_range.
# ie. wood: 70 -> wood : 0-69; iron 20 -> 70-89
func add_rarity_range(rarity_data, total_range):
	var rarity_weight = rarity_data._rarity_weight
	rarity_data._targeting_types_ranges = generate_weighted_ranges(rarity_data._targeting_types_ranges)
	rarity_data._damage_types_range = generate_weighted_ranges(rarity_data._damage_types_range)
	rarity_data._damage_min_range = generate_weighted_ranges(rarity_data._damage_min_range)
	rarity_data._damage_max_range = generate_weighted_ranges(rarity_data._damage_max_range)
	var new_total_range = rarity_weight+total_range
	_rarity_ranges.append([new_total_range, rarity_data])
	return new_total_range


# Calculates the sequential weight of a range of parameters.
# Since parameter weights are not summed in their respective 
# rarity classes (ie. _targeting_ranges in "wood"), we sum
# the total range value here and calculate the final array.
func generate_weighted_ranges(ranges):
	var weighted_ranges = []
	var total_range = 0
	for range in ranges:
		weighted_ranges.append([range[0]+total_range, range[1]])
		total_range += range[0]
	return weighted_ranges


func load_targeting_types():
	var directory_path = "res://Encounter/Generator/Gear/Weapons/Targeting"
	var targeting_data
	
	for file_name in DirAccess.get_files_at(directory_path): # iterate rarity classes
		targeting_data = load(directory_path + "/" + file_name).new()
		_targeting_types[targeting_data._name] = targeting_data._targetable_tiles




#=== Callable Logic ===#

func generate_random_weapon():
	var rarity_data = generate_data_from_ranges(_rarity_ranges)
	var weapon = _weapon_prefab.new()
	weapon._rarity = rarity_data._name
	weapon._targeting = generate_weapon_targeting(rarity_data._targeting_types_ranges)
	weapon._damage_types = generate_weapon_damage( \
		rarity_data._damage_types_range, \
		rarity_data._damage_min_range, rarity_data._damage_max_range)
#	var _modifiers #TODO
	weapon._expiration = generate_value_in_range(rarity_data._expiration_range)
	weapon._name = weapon.build_weapon_name()
	weapon.print_stats()
	return weapon




#=== Generation ===#

# Generate a total number of targeting types, then draft that number of
# targeting types from the pool.
func generate_weapon_targeting(targeting_types_ranges):
	var total_targeting_types = generate_data_from_ranges(targeting_types_ranges)
	var undrafted_targeting_types = _targeting_types.keys()
	var drafted_targeting_types = {} # the randomly drafted targeting types
	var drafted_targeting_idx
	var drafted_targeting_name
	for i in range(0, total_targeting_types):
		drafted_targeting_idx = generate_value_in_range([0, undrafted_targeting_types.size()-1])
		drafted_targeting_name = undrafted_targeting_types[drafted_targeting_idx]
		drafted_targeting_types[drafted_targeting_name] = _targeting_types[drafted_targeting_name]
		undrafted_targeting_types.remove_at(drafted_targeting_idx)
	return drafted_targeting_types

# Generate a total number of damage types, then assign a random damage interval
# for each drafted  damage type (physical/magical).
func generate_weapon_damage(damage_types_range, damage_min_range, damage_max_range):
	var total_damage_types = generate_data_from_ranges(damage_types_range)
	var damage_types = {} # {"damage_type": [min_dmg, max_dmg]}
	if total_damage_types == 1:
		var rand_val = randi_range(0, 2)
		if rand_val == 0:
			damage_types["physical"] = generate_weapon_min_max_damage(damage_min_range, damage_max_range)
		else:
			damage_types["magical"] = generate_weapon_min_max_damage(damage_min_range, damage_max_range)
	else: # both damage types (physical/magical)
		pass
		damage_types["physical"] = generate_weapon_min_max_damage(damage_min_range, damage_max_range)
		damage_types["magical"] = generate_weapon_min_max_damage(damage_min_range, damage_max_range)
	
	return damage_types


# Generates the minimum and maximum damage intervals for a weapon.
# The minimum value within a range is calculated first, then a maximum
# value within a range is added to the minimum value initially generated.
func generate_weapon_min_max_damage(damage_min_range, damage_max_range):
	var min_damage_interval = generate_data_from_ranges(damage_min_range)
	var min_damage = generate_value_in_range(min_damage_interval)
	var max_damage_interval = generate_data_from_ranges(damage_max_range)
	var max_damage = generate_value_in_range(min_damage_interval)
	return [min_damage, min_damage+max_damage]



#=== Utils ===#

# Returns a random data value from within a range, then iterates all the values
# in the range until one that is greater than the random value originally
# Then, returns the target data associated with the specific range.
# NOTE the ranges must pass through generate_weighted_ranges() first.
# This is usually done when loading the class, on add_rarity_range().
func generate_data_from_ranges(data_range):
	var total_range = data_range[data_range.size()-1][0] # the range of the last element
	var generated_value = randi_range(0, total_range)
	var target = data_range[0][1] # the first rarity data, as the default
	for range_data in data_range:
		if range_data[0] > generated_value: # range_data[0] = range_value
			target = range_data[1] # range_data[1] = rarity_data
			break
	return target



func generate_value_in_range(value_range):
	var generated_value = ceil(randf_range(value_range[0]-1, value_range[1]))
	return generated_value



