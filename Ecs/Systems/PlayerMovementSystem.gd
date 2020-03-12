extends "res://Ecs/Core/System.gd"

const MovementControl = preload("res://Core/Utils/MovementControl.gd")

func _init():
	._init()
	required_components = ["PlayerControlComponent"]

func recheck_entity(entity):
	.recheck_entity(entity)
	if entity in entities:
		entity.connect("integrate_forces", self, "on_integrate_forces", [entity])

func on_integrate_forces(state, entity):
	var direction = MovementControl.get_movement_from_actions("up", "right", "down", "left")
	var movement = (direction * Constants.PLAYER_SPEED)
	state.linear_velocity = (state.linear_velocity + movement).clamped(Constants.PLAYER_SPEED)
