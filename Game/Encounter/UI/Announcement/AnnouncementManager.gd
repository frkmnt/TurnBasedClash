extends AnimationPlayer

#=== About ===#
# This class emits the in-game announcements. This includes new rounds, game start, game finish, etc. It stores animations which are tuned
# at the beggining of the match.


#=== Components ===#
var _announcement # the announcement label



#=== Bootstrap ===#

func _ready():
	_announcement = $Announcement



#=== Emit Announcement ===#

func emit_game_start_announcement():
	_announcement.initialize_in_game_start_mode()
	SignalManager.emit_signal("_on_register_log", "Entering Combat!")
	play("GameStart")

func emit_round_announcement(round_num):
	_announcement.initialize_in_round_mode(round_num)
	SignalManager.emit_signal("_on_register_log", "\n Round " + str(round_num) + " begins.")
	play("NewRound")



#=== Announcement Finished ===#

func on_announcement_finished(anim_id):
	match anim_id:
		"GameStart":
			on_game_start_announcement_finished()
		"NewRound":
			on_turn_announcement_finished()

func on_game_start_announcement_finished():
	SignalManager.emit_signal("_on_game_start_announcement_finished")

func on_turn_announcement_finished():
	SignalManager.emit_signal("_on_turn_announcement_finished")


