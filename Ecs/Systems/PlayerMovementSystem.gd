extends "res://Ecs/Core/System.gd"

func _init():
	._init()
	required_components = ["PlayerControlComponent"]

func recheck_entity(entity):
	.recheck_entity(entity)
	if entity in entities:
		entity.connect("integrate_forces", self, "on_integrate_forces", [entity])

func on_integrate_forces(state, entity):
	var direction = Vector2()
	if Input.is_action_pressed("up"):
		direction.y = -1
	if Input.is_action_pressed("down"):
		direction.y = 1
	if Input.is_action_pressed("left"):
		direction.x = -1
	if Input.is_action_pressed("right"):
		direction.x = 1
	var movement = (direction * Constants.PLAYER_SPEED).clamped(Constants.PLAYER_SPEED)
	state.linear_velocity = movement
