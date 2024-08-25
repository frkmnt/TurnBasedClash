extends Resource

@export var value: String = "Ring" 
@export var index: int = 0  # The armor value
var _list_type_slots = [ #TODO DYNAMIC
		{ "name": "Headset", "items": [] },
		{ "name": "Armor", "items": [] },
		{ "name": "Weapon", "items": [] },
		{ "name": "Ring", "items": [] },
	]
# Function to randomly assign an armor value
func randomize(): 
	index = randi() % _list_type_slots.size() # Random armor between 1 and size of types of slots
	value = _list_type_slots[index].name
