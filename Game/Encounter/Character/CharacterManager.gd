extends Node

#=== About ===#
# Handles the interactions for both heroes and enemies during an encounter.
# Responsible for generating enemies based on the encounter difficulty.
# TODO handle had_turn, in case a character loses speed after their turn and is re-sorted for another turn in the _turn_queue



#=== References ===#
var _map_manager

#=== Constants ===#
const _ally_team_id = "blue"
const _enemy_team_id = "red"

#=== Variables ===#
var _character_data = {} # matches each char_id to a dict of {"character": character_obj, "team_id": "team_str", "had_turn": bool}
var _ally_ids = []
var _enemy_ids = []

var _turn_queue = [] # List of character_id. Ordered highest->lowest speed. 
var _cur_character_idx = -1



#=== Bootstrap ===#

func initialize(party, enemies):
	_map_manager = get_parent()._map_manager
	initialize_party(party)
	initialize_enemies(enemies)
	sort_turn_queue()


func initialize_party(party):
	var hero
	for i in range(party.size()):
		hero = party[i]
		_character_data[i] = {"character": hero, "team_id": _ally_team_id, "had_turn": false}
		_turn_queue.append(i)
		_ally_ids.append(i)
		add_child(hero)


func initialize_enemies(enemies):
	var enemy
	var hero_id_offset = _turn_queue.size() # required to continue the id count increment, ie 2 heros with id 0 and 1, enemy_id = 2+0, 2+1, ...
	for i in range(enemies.size()):
		enemy = enemies[i]
		_character_data[i+hero_id_offset] = {"character": enemy, "team_id": _enemy_team_id, "had_turn": false}
		_turn_queue.append(i+hero_id_offset)
		_enemy_ids.append(i+hero_id_offset)
		add_child(enemy)



#=== Turn Queue ===#

func sort_turn_queue():
	_turn_queue.clear()
	var aux_queue = []
	for char_id in _character_data.keys():
		aux_queue.append([char_id, get_character_speed(char_id)])
	aux_queue.sort_custom(sort_by_speed)
	for data in aux_queue:
		_turn_queue.append(data[0]) # the appended speed

func sort_by_speed(data_a, data_b):
	var speed_a = data_a[1]
	var speed_b = data_b[1]
	var is_a_faster = (speed_a > speed_b)

	if speed_a == speed_b:
		var rand_selection = randi_range(0, 1)
		if rand_selection == 1:
			is_a_faster = true
	
	return is_a_faster

func turn_start():
	_cur_character_idx += 1
	if _cur_character_idx >= _turn_queue.size(): # increment rounds
		_cur_character_idx = 0
		sort_turn_queue()
	var character = get_current_character()
	character.on_turn_start()

func is_turn_over():
	var is_over = false
	var cur_speed = get_current_character_current_speed()
	if cur_speed <= 0: # TODO also add status effect checks
		is_over = true
	return is_over



#=== Stats ===#

func decrease_character_current_speed(char_id, speed_cost):
	var character = get_character_by_id(char_id)
	var new_speed = character._stats.sub_cur_speed(speed_cost)
	return new_speed



#=== Getters ===#

func get_current_character():
	return get_character_by_id(_turn_queue[_cur_character_idx])

func get_character_by_id(id):
	return _character_data.get(id).get("character")

func get_current_character_id():
	return _turn_queue[_cur_character_idx]


func get_current_character_current_speed():
	return get_current_character()._stats._cur_speed

func get_character_speed(char_id):
	return _character_data.get(char_id).get("character")._stats._speed

func get_current_character_had_turn(char_id):
	return _character_data.get(char_id).get("had_turn")



#=== Movement ===#

func move_character_along_path(char_id, path):
	var character = get_character_by_id(char_id)
	character.on_move(path)



#=== Enemy Management ===#

func find_nearest_heroes():
	var cur_char_id = _turn_queue[0]
	var cur_char_coords = _map_manager._character_coords.get(cur_char_id)
	return _map_manager.calculate_nearest_heroes(cur_char_coords, _ally_ids) # TODO add random if this list's size >1



#=== Utils ===#

func is_ally_of_current_character(char_id):
	var cur_team = _character_data.get(get_current_character_id()).get("team_id")
	return _character_data.get(char_id).get("team_id") == cur_team

