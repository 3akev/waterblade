extends "res://Core/System.gd"

func _init():
	required_components = ["PlayerMovementComponent"]

func _process(delta):
	for entity in entities:
		var direction = Vector2()
		if Input.is_action_pressed("up"):
			direction.y = -1
		if Input.is_action_pressed("down"):
			direction.y = 1
		if Input.is_action_pressed("left"):
			direction.x = -1
		if Input.is_action_pressed("right"):
			direction.x = 1
		var movement = (direction * Constants.PLAYER_SPEED * delta).clamped(Constants.PLAYER_SPEED * delta)
		entity.move_and_collide(movement)
