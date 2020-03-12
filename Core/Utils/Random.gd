extends Node

static func get_randomized_array(array):
	var duplicate = array.duplicate()
	duplicate.shuffle()
	return duplicate

static func get_random_element(array):
	return get_randomized_array(array)[0]
