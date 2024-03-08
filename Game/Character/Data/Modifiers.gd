extends Node

#==== Modifier IDs ====#
# poison                 



#==== Modifier Triggers ====#
# passive
# turn_start
# turn_end
# round_start
# round_end
# move
# receive_hit
# receive_modifier
# deal_hit
# deal_modifier
# modifier_activation
# receive_heal


var _parent_hero

# dictionary of modifier_trigger : modifiers{}
# identifiers: turn_start, turn_end, attack, skill, receive_attack, move, finish_moving
var _modifier_map = {}


# Local modifiers (bool)
#var can_move = true
#var can_attack = true





#=== Bootstrap ===#

func initialize(parent_class):
	_parent_hero = parent_class




#=== Modifier Interface ===#

func add_modifier(modifier):
	var was_added = true #TODO check if any modifiers prevent the new one from being added
	modifier.initialize(_parent_hero)
	for modifier_trigger in modifier._triggers:
		if _modifier_map.has(modifier_trigger):
			var modifiers = _modifier_map.get(modifier_trigger)
			if modifiers.has(modifier._id):
				modifiers[modifier._id].on_stack(modifier)
			else: # the modifier doesn't exist
				modifiers[modifier._id] = modifier
		else: # no entries for the trigger exist
			var new_map = {}
			new_map[modifier._id] = modifier
			_modifier_map[modifier_trigger] = new_map
	return was_added



#=== Event Management ===#

# Called when a character's turn starts. Returns the generated log.
func on_turn_start():
	return apply_event_modifiers("turn_start")





#=== Utils ===#

# Dynamically applies an event's modifiers (ie on_turn_start) based on the modifier
# trigger. Returns the generated logs. This reduces overall function redundancy.
func apply_event_modifiers(modifier_trigger):
	var log = ""
	var modifiers_to_remove = []
	var call_func = "on_" + modifier_trigger
	if _modifier_map.has(modifier_trigger):
		for modifier in _modifier_map.get(modifier_trigger).values():
			log += modifier.call(call_func)
			if modifier._needs_to_be_removed:
				modifiers_to_remove.append(modifier)
	remove_modifiers(modifiers_to_remove)
	return log 

# Removes the modifiers after iterating the list, so as to not cause conflicts.
func remove_modifiers(modifiers_to_remove):
	var modifier_list
	var modifier_index
	if modifiers_to_remove.size() > 0:
		for modifier in modifiers_to_remove:
			for trigger in modifier._triggers:
				modifier_list = _modifier_map.get(trigger)
				modifier_list.erase(modifier._id)

