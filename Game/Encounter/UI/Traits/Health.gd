extends Resource

@export var value: int = 0  # The health value

# Function to randomly assign a health value
func randomize():
	value = randi() % 100 + 1  # Random health between 1 and 100
