extends Node

const Directions = preload("res://Core/Utils/Directions.gd")

static func get_random_room(d):
	randomize()
	var ls = d.rooms.keys()
	ls.shuffle()
	return ls[0]

static func get_adjacent_non_connected_room(d, slot):
	for v in Directions.get_randomized_directions():
		if d.rooms.get(slot + v, null) != null and not [slot, slot + v] in d.tunnels and not [slot + v, slot] in d.tunnels:
			return slot + v
	return null

static func get_adjacent_space(d, slot):
	for v in Directions.get_randomized_directions():
		if d.rooms.get(slot + v, null) == null:
			return slot + v 
	return null

static func map_to_world(d, tilemap):
	var scaled = d.duplicate()
	for slot in d.rooms:
		scaled.rooms[slot] = map_rect_to_world(tilemap, d.rooms[slot])
	for slot in d.tunnels:
		scaled.tunnels[slot] = map_rect_to_world(tilemap, d.tunnels[slot])
	for slot in d.floors:
		scaled.floors[slot] = map_rect_to_world(tilemap, d.floors[slot])
	return scaled

static func map_rect_to_world(tilemap, rect):
	return Rect2(tilemap.map_to_world(rect.position), tilemap.map_to_world(rect.size))
