extends Node

var directions = preload("res://Core/Utils/Directions.gd").new()

var rooms = {}
var tunnels = {}

func get_random_room():
	randomize()
	var ls = rooms.keys()
	ls.shuffle()
	return ls[0]

func get_adjacent_non_connected_room(slot):
	for v in directions.get_randomized_directions():
		if rooms.get(slot + v, null) != null and not [slot, slot + v] in tunnels and not [slot + v, slot] in tunnels:
			return slot + v
	return null

func get_adjacent_space(slot):
	for v in directions.get_randomized_directions():
		if rooms.get(slot + v, null) == null:
			return slot + v 
	return null

func add_room(slot, rect):
	rooms[slot] = rect

func add_tunnel(slot, rect):
	tunnels[slot] = rect
