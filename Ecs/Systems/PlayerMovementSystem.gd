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
	if state.linear_velocity.is_equal_approx(Vector2()):
		state.add_central_force(-entity.applied_force)
		
	if entity.applied_force.length() > Constants.PLAYER_SPEED:
		var clamped = entity.applied_force.clamped(Constants.PLAYER_SPEED)
		state.add_central_force(clamped - entity.applied_force)
	
	var direction = MovementControl.get_movement_from_actions("up", "right", "down", "left")
	var movement = (direction * Constants.PLAYER_SPEED)
	state.add_central_force(movement)
	state.linear_velocity = state.linear_velocity.clamped(Constants.PLAYER_SPEED)
