extends "res://Core/StateMachine/State.gd"

func _ready():
	target.connect("integrate_forces", self, "on_integrate_forces")

func on_integrate_forces(state):
	var player = Locator.get_player()
	var direction = target.position.direction_to(player.position)
	var distance = target.position.distance_to(player.position)
	if distance < 200:
		state.linear_velocity = direction * 50
