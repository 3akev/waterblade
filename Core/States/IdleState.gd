extends "res://Core/StateMachine/State.gd"

var time_idling = 0

func _process(delta):
	time_idling += delta
	if time_idling > Constants.ENEMY_IDLE_TIME:
		transition_randomly()

func _on_enter_state():
	time_idling = 0
