extends "res://Core/StateMachine/State.gd"

const Directions = preload("res://Core/Utils/Directions.gd")

var direction
var elapsed = 0

func on_integrate_forces(state):
	if not is_active():
		return
	elapsed += state.step
	target.linear_velocity = direction * Constants.ENEMY_SPEED
	if elapsed > Constants.ENEMY_WANDER_TIME:
		state_machine.transition("idle")
		target.linear_velocity = Vector2.ZERO

func _on_enter_state():
	elapsed = 0
	direction = Directions.get_random_direction_vector()
	target.connect("integrate_forces", self, "on_integrate_forces")

func _on_exit_state():
	target.disconnect("integrate_forces", self, "on_integrate_forces")
