extends Node
var rng

func _init(_rng):
	rng = _rng

func create_room(room_slot):
	var room = Rect2(0, 0, rng.randi_range(Constants.MIN_ROOM_SIZE.x, Constants.MAX_ROOM_SIZE.x), rng.randi_range(Constants.MIN_ROOM_SIZE.y, Constants.MAX_ROOM_SIZE.y))
	room.position = room_slot * Constants.ROOM_SLOT_SIZE
	room.position.x += (Constants.ROOM_SLOT_SIZE.x * (room_slot.x + 1) - room.end.x) / 2
	room.position.y += (Constants.ROOM_SLOT_SIZE.y * (room_slot.y + 1) - room.end.y) / 2
	return room

func create_h_tunnel(room1, room2):
	var x
	var length
	if room1.position.x < room2.position.x:
		x = room1.end.x
		length = room2.position.x - room1.end.x
	else:
		x = room2.end.x
		length = room1.position.x - room2.end.x
	
	var y = room1.position.y + (room1.size.y - Constants.TUNNEL_WIDTH)/2
	var tunnel = Rect2(x, y, length, Constants.TUNNEL_WIDTH)
	return tunnel

func create_v_tunnel(room1, room2):
	var y
	var length
	if room1.position.y < room2.position.y:
		y = room1.end.y
		length = room2.position.y - room1.end.y
	else:
		y = room2.end.y
		length = room1.position.y - room2.end.y
	
	var x = room1.position.x + (room1.size.x - Constants.TUNNEL_WIDTH)/2
	var tunnel = Rect2(x, y, Constants.TUNNEL_WIDTH, length)
	return tunnel
