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
	if direction in [Vector2.UP, Vector2.DOWN]:
		dungeon_placer.create_v_tunnel(rooms[previous_room_slot], room)
	else:
		dungeon_placer.create_h_tunnel(rooms[previous_room_slot], room)
	rooms[room_slot] = room

func get_room(room_slot):
	var room = Rect2(0, 0, rng.randi_range(Constants.MIN_ROOM_SIZE.x, Constants.MAX_ROOM_SIZE.x), rng.randi_range(Constants.MIN_ROOM_SIZE.y, Constants.MAX_ROOM_SIZE.y))
	room.position = room_slot * Constants.ROOM_SLOT_SIZE
	room.position.x += (Constants.ROOM_SLOT_SIZE.x * (room_slot.x + 1) - room.end.x) / 2
	room.position.y += (Constants.ROOM_SLOT_SIZE.y * (room_slot.y + 1) - room.end.y) / 2
	return room
