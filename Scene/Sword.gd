extends Area2D

onready var sprite = $Sprite
onready var shape = $CollisionShape2D

func _process(delta):
	if Input.is_action_just_pressed("sword_swing"):
		position = Vector2(0, 0)
	elif Input.is_action_just_released("sword_swing"):
		position = Vector2(5, -5)
		rotation = PI/4
		sprite.scale = Vector2(1, 1)
		shape.shape.b.y = 15
	if Input.is_action_pressed("sword_swing"):
		var direction = Vector2()
		if Input.is_action_pressed("sword_down"):
			direction.y = Input.get_action_strength("sword_down")
		if Input.is_action_pressed("sword_left"):
			direction.x = -Input.get_action_strength("sword_left")
		if Input.is_action_pressed("sword_right"):
			direction.x = Input.get_action_strength("sword_right")
		if Input.is_action_pressed("sword_up"):
			direction.y = -Input.get_action_strength("sword_up")
		
		var prev_rotation = rotation
		rotation = lerp_angle(rotation, direction.angle() - PI/2, 0.2)
		var velocity = abs(rotation - prev_rotation) * 5
		sprite.scale = Vector2(1 + velocity, 1 + velocity)
		shape.shape.b.y = 15 + pow(velocity, 2)
