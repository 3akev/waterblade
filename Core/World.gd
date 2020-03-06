extends Node2D

onready var tilemap = $TileMap
var floor_index
var wall_index
var rng = RandomNumberGenerator.new()
var directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

var rooms = {}


func _ready():
	VisualServer.set_default_clear_color(Color.black)
	floor_index = tilemap.tile_set.find_tile_by_name("Floor")
	wall_index = tilemap.tile_set.find_tile_by_name("Wall")
	
	rng.randomize()
	create_dungeon()

func create_dungeon():
	var room = get_room(Vector2(0, 0))
	create_room(room)
	rooms[Vector2(0, 0)] = room
	
	var num_rooms = rng.randi_range(Constants.MIN_ROOMS_PER_DUNGEON, Constants.MAX_ROOMS_PER_DUNGEON) - 1
	for i in range(num_rooms):
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

	create_room(room)
	if direction in [Vector2.UP, Vector2.DOWN]:
		create_v_tunnel(rooms[previous_room_slot], room)
	else:
		create_h_tunnel(rooms[previous_room_slot], room)
	rooms[room_slot] = room

func get_room(room_slot):
	var room = Rect2(0, 0, rng.randi_range(Constants.MIN_ROOM_SIZE.x, Constants.MAX_ROOM_SIZE.x), rng.randi_range(Constants.MIN_ROOM_SIZE.y, Constants.MAX_ROOM_SIZE.y))
	room.position = room_slot * Constants.ROOM_SLOT_SIZE
	room.position.x += (Constants.ROOM_SLOT_SIZE.x * (room_slot.x + 1) - room.end.x) / 2
	room.position.y += (Constants.ROOM_SLOT_SIZE.y * (room_slot.y + 1) - room.end.y) / 2
	return room

func create_room(rect):
	# place walls around the room
	for x in range(rect.position.x, rect.end.x + 1):
		tilemap.set_cell(x, rect.position.y, wall_index)
		tilemap.set_cell(x, rect.end.y, wall_index)
	for y in range(rect.position.y, rect.end.y + 1):
		tilemap.set_cell(rect.position.x, y, wall_index)
		tilemap.set_cell(rect.end.x, y, wall_index)
	
	# place floors in the room
	for x in range(rect.position.x + 1, rect.end.x):
		for y in range(rect.position.y + 1, rect.end.y):
			tilemap.set_cell(x, y, floor_index)

func create_h_tunnel(room1, room2):
	var start
	var end
	if room1.position.x < room2.position.x:
		start = room1.end.x
		end = room2.position.x
	else:
		start = room2.end.x
		end = room1.position.x
	var y = clamp(room1.position.y + room1.size.y/2, room2.position.y + 2, room2.end.y - 2)
	for x in range(start, end + 1):
		tilemap.set_cell(x, y - 1, wall_index)
		tilemap.set_cell(x, y, floor_index)
		tilemap.set_cell(x, y + 1, floor_index)
		tilemap.set_cell(x, y + 2, wall_index)
 
func create_v_tunnel(room1, room2):
	var start
	var end
	if room1.position.y < room2.position.y:
		start = room1.end.y
		end = room2.position.y
	else:
		start = room2.end.y
		end = room1.position.y
	var x = clamp(room1.position.x + room1.size.x/2, room2.position.x + 2, room2.end.x - 2)
	for y in range(start, end + 1):
		tilemap.set_cell(x - 1, y, wall_index)
		tilemap.set_cell(x, y, floor_index)
		tilemap.set_cell(x + 1, y, floor_index)
		tilemap.set_cell(x + 2, y, wall_index)
