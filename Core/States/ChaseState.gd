extends "res://Core/StateMachine/State.gd"

const DT = preload("res://Core/Utils/DungeonTools.gd")

var dungeon = Locator.get_dungeon()

func _ready():
	target.connect("integrate_forces", self, "on_integrate_forces")

func on_integrate_forces(state):
	var player = Locator.get_player()
	var direction = target.position.direction_to(player.position)
	var distance = target.position.distance_to(player.position)
	if DT.get_room_containing_point(dungeon, target.position) == DT.get_room_containing_point(dungeon, player.position):
		state.linear_velocity = direction * 50
	else:
		state.linear_velocity = Vector2.ZERO
