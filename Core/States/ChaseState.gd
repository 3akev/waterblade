extends "res://Core/StateMachine/State.gd"

const DT = preload("res://Core/Utils/DungeonTools.gd")

var dungeon = Locator.get_dungeon()
var player

func _on_enter_state():
	player = Locator.get_player()
	target.connect("integrate_forces", self, "on_integrate_forces")

func on_integrate_forces(state):
	if not is_active():
		return
	var direction = target.position.direction_to(player.position)
	var distance = target.position.distance_to(player.position)
	if DT.get_room_containing_point(dungeon, target.position) == DT.get_room_containing_point(dungeon, player.position):
		state.linear_velocity = direction * Constants.ENEMY_SPEED
	else:
		state.linear_velocity = Vector2.ZERO
		state_machine.transition("idle")

func _on_exit_state():
	target.disconnect("integrate_forces", self, "on_integrate_forces")
