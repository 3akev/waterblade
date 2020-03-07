extends Node

const DungeonPlacer = preload("res://Core/Dungeon/DungeonPlacer.gd")
const directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

var rng
var dungeon_placer
var rooms = {}

func _init(_rng, tilemap):
	rng = _rng
	dungeon_placer = DungeonPlacer.new(tilemap)

func generate_dungeon():
	var room = get_room(Vector2(0, 0))
	dungeon_placer.place_room(room)
	rooms[Vector2(0, 0)] = room
	
	var num_rooms = rng.randi_range(Constants.MIN_ROOMS_PER_DUNGEON, Constants.MAX_ROOMS_PER_DUNGEON) - 1
	for _i in range(num_rooms):
		create_next_room()

func create_next_room():
	var room_slots = rooms.keys()
	room_slots.shuffle()
	
	var previous_room_slot = room_slots[0]
	
	var direction = directions[rng.randi_range(0, 3)]
	var room_slot = previous_room_slot + direction
	
	if room_slot in rooms:
		return create_next_room()

	var room = get_room(room_slot)

	dungeon_placer.place_room(room)
	rooms[room_slot] = room
	create_tunnel(previous_room_slot, room_slot)

func create_tunnel(slot1, slot2):
	var direction = slot1 - slot2
	if direction in [Vector2.UP, Vector2.DOWN]:
		var tunnel = get_v_tunnel(rooms[slot1], rooms[slot2])
		dungeon_placer.place_v_tunnel(tunnel)
	else:
		var tunnel = get_h_tunnel(rooms[slot1], rooms[slot2])
		dungeon_placer.place_h_tunnel(tunnel)

func get_room(room_slot):
	var room = Rect2(0, 0, rng.randi_range(Constants.MIN_ROOM_SIZE.x, Constants.MAX_ROOM_SIZE.x), rng.randi_range(Constants.MIN_ROOM_SIZE.y, Constants.MAX_ROOM_SIZE.y))
	room.position = room_slot * Constants.ROOM_SLOT_SIZE
	room.position.x += (Constants.ROOM_SLOT_SIZE.x * (room_slot.x + 1) - room.end.x) / 2
	room.position.y += (Constants.ROOM_SLOT_SIZE.y * (room_slot.y + 1) - room.end.y) / 2
	return room

func get_h_tunnel(room1, room2):
	var x
	var length
	if room1.position.x < room2.position.x:
		x = room1.end.x
		length = room2.position.x - room1.end.x
	else:
		x = room2.end.x
		length = room1.position.x - room2.end.x
	
	var y = clamp(room1.position.y + room1.size.y/2, room2.position.y + 2, room2.end.y - 2)
	var tunnel = Rect2(x, y, length, Constants.TUNNEL_WIDTH)
	return tunnel

func get_v_tunnel(room1, room2):
	var y
	var length
	if room1.position.y < room2.position.y:
		y = room1.end.y
		length = room2.position.y - room1.end.y
	else:
		y = room2.end.y
		length = room1.position.y - room2.end.y
	
	var x = clamp(room1.position.x + room1.size.x/2, room2.position.x + 2, room2.end.x - 2)
	var tunnel = Rect2(x, y, Constants.TUNNEL_WIDTH, length)
	return tunnel
