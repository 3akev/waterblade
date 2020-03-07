extends Node

const Directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

static func get_randomized_directions():
	randomize()
	var ls = Directions.duplicate()
	ls.shuffle()
	return ls
