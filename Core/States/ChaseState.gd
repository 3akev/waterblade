extends "res://Core/StateMachine/State.gd"

var player

func _init():
	Events.connect("spawned_player", self, "on_spawned_player")

func _ready():
	target.connect("integrate_forces", self, "on_integrate_forces")

func on_spawned_player(_player):
	player = _player

func on_integrate_forces(state):
	var direction = target.position.direction_to(player.position)
	var distance = target.position.distance_to(player.position)
	if distance < 200:
		state.linear_velocity = direction * 50
