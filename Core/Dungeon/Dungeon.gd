extends Node

var rooms = {}
var tunnels = {}

func get_random_room():
	var ls = rooms.keys()
	ls.shuffle()
	return ls[0]

func add_room(slot, rect):
	rooms[slot] = rect

func add_tunnel(slot, rect):
	tunnels[slot] = rect
