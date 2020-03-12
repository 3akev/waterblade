extends Node


static func get_movement_from_actions(up: String, right: String, down: String, left: String):
		var direction = Vector2()
		if Input.is_action_pressed(up):
			direction.y = -Input.get_action_strength(up)
		if Input.is_action_pressed(right):
			direction.x = Input.get_action_strength(right)
		if Input.is_action_pressed(down):
			direction.y = Input.get_action_strength(down)
		if Input.is_action_pressed(left):
			direction.x = -Input.get_action_strength(left)
		return direction
