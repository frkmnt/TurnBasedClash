extends Resource

@export var value: int = 0  # The armor value

# Function to randomly assign an armor value
func randomize():
	value = randi() % 50 + 1  # Random armor between 1 and 50
