extends Area2D

onready var entity = get_parent()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		enter_swing_mode(event)
	elif event is InputEventMouseButton and not event.pressed:
		exit_swing_mode(event)
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		swing_sword(event)

func swing_sword(event):
	var angle_to_mouse = entity.get_angle_to(get_global_mouse_position())
	
	var prev_rotation = rotation
	rotation = lerp_angle(rotation, angle_to_mouse - PI/2, 0.2)
	var velocity = abs(rotation - prev_rotation) * 5
	scale = Vector2(1 + velocity, 1 + velocity)

func enter_swing_mode(event):
	position = Vector2(0, 0)

func exit_swing_mode(event):
	position = Vector2(5, -5)
	rotation = PI/4
	scale = Vector2(1, 1)
