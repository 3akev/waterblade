extends "res://Core/StateMachine/State.gd"

var player

func _init():
	Events.connect("spawned_player", self, "on_spawned_player")

func on_spawned_player(_player):
	player = _player

func _process(delta):
	var direction = target.position.direction_to(player.position)
	var distance = target.position.distance_to(player.position)
	if distance < 500:
		target.move_and_slide(direction * 50)
