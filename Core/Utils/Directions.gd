extends Node

const Random = preload("res://Core/Utils/Random.gd")
const Directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

static func get_randomized_directions():
	return Random.get_randomized_array(Directions)

static func get_random_direction_vector():
	return Vector2(get_random_sign() * randf(), get_random_sign() * randf()).normalized()
	
static func get_random_sign():
	if randf() > 0.5:
		return 1
	else:
		return -1
