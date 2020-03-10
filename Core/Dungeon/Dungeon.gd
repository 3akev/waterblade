extends Node

var rooms = {}
var tunnels = {}

func add_room(slot, rect):
	rooms[slot] = rect

func add_tunnel(slot, rect):
	tunnels[slot] = rect
