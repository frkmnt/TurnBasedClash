extends Resource

@export var value: int = 0  # The speed value

# Function to randomly assign a speed value
func randomize():
	value = randi() % 20 + 1  # Random speed between 1 and 20
