extends "res://Core/System.gd"

var player

func recheck_entity(entity):
	if entity.get_node_or_null("Sword") != null:
		player = entity

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		Input.action_press("sword_swing")
	elif event is InputEventMouseButton and not event.pressed:
		Input.action_release("sword_swing")
		Input.action_release("sword_right")
		Input.action_release("sword_left")
		Input.action_release("sword_down")
		Input.action_release("sword_up")
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(BUTTON_LEFT):
		var angle_to_mouse = player.get_angle_to(get_global_mouse_position())
#		print(angle_to_mouse)
		var vec = Vector2(cos(angle_to_mouse), sin(angle_to_mouse))
		print(str(vec.x) + " " + str(vec.y))

		if vec.x > 0:
			Input.action_press("sword_right", abs(vec.x))
			Input.action_release("sword_left")
		elif vec.x < 0:
			Input.action_press("sword_left", abs(vec.x))
			Input.action_release("sword_right")
		if vec.y > 0:
			Input.action_press("sword_down", abs(vec.y))
			Input.action_release("sword_up")
		elif vec.y < 0:
			Input.action_press("sword_up", abs(vec.y))
			Input.action_release("sword_down")
