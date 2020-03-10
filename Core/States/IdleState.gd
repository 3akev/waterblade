extends "res://Core/StateMachine/State.gd"

var time_idling = 0

func _init():
	id = "idle"

func _process(delta):
	time_idling += delta
	if time_idling > 0.75:
		state_machine.transition("chase")

func _on_enter_state():
	time_idling = 0
