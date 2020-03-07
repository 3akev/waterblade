extends Node

var rooms = {}
var tunnels = {}

func get_random_room():
	var ls = rooms.keys()
	ls.shuffle()
	return ls[0]
