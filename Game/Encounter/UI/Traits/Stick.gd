extends Resource

#X player and 0,0 coordenates
#0 and 1 is the value 0 or 1
#- is the value -1

#- - 0 - -
#- - 1 - -
#0 1 X 1 0
#- - 1 - -
#- - 0 - -
# The coordenates above
@export var value := { 
	[-2,  2]: -1, [-1,  2]: -1, [0,  2]:  0, [1,  2]: -1, [2,  2]: -1,
	[-2,  1]: -1, [-1,  1]: -1, [0,  1]:  1, [1,  1]: -1, [2,  1]: -1,
	[-2,  0]:  0, [-1,  0]:  1, [0,  0]: "X", [1,  0]:  1, [2,  0]:  0,
	[-2, -1]: -1, [-1, -1]: -1, [0, -1]:  1, [1, -1]: -1, [2, -1]: -1,
	[-2, -2]: -1, [-1, -2]: -1, [0, -2]:  0, [1, -2]: -1, [2, -2]: -1
}

# Function to return pathing
func get_targeting():
	return value
