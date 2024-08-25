extends Resource

@export var name: String
@export var health: Resource  # This will hold an instance of Health
@export var speed: Resource   # This will hold an instance of Speed
@export var armor: Resource   # This will hold an instance of Armor
@export var type: Resource   # This will hold an instance of Armor

# Function to randomize all traits of the gear
func randomize_traits():
	if health:
		health.randomize()
	if speed:
		speed.randomize()
	if armor:
		armor.randomize()
	if type:
		type.randomize()

# Function to print the gear's stats (for testing purposes)
func print_stats():
	print(type ," Name: ", name)
	if health:
		print("Health: ", health.value)
	if speed:
		print("Speed: ", speed.value)
	if armor:
		print("Armor: ", armor.value)
