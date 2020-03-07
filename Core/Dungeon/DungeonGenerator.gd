extends Node

const DungeonPlacer = preload("res://Core/Dungeon/DungeonPlacer.gd")
const DungeonCreator = preload("res://Core/Dungeon/DungeonCreator.gd")
const Dungeon = preload("res://Core/Dungeon/Dungeon.gd")
const directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

var rng
var placer
var creator

func _init(_rng, tilemap):
	rng = _rng
	placer = DungeonPlacer.new(tilemap)
	creator = DungeonCreator.new(rng)

func generate_dungeon():
	var dungeon = Dungeon.new()
	var room = creator.create_room(Vector2(0, 0))
	placer.place_room(room)
	dungeon.rooms[Vector2(0, 0)] = room
	
	var num_rooms = rng.randi_range(Constants.MIN_ROOMS_PER_DUNGEON, Constants.MAX_ROOMS_PER_DUNGEON) - 1
	for _i in range(num_rooms):
		generate_next_room(dungeon)
	
	var num_extra_tunnels = rng.randi_range(Constants.MIN_EXTRA_TUNNELS, Constants.MAX_EXTRA_TUNNELS)
	for _i in range(num_extra_tunnels):
		generate_extra_tunnel(dungeon)

func generate_next_room(dungeon):
	var room_slots = dungeon.rooms.keys()
	room_slots.shuffle()
	
	var previous_room_slot = room_slots[0]
	
	var direction = directions[rng.randi_range(0, 3)]
	var room_slot = previous_room_slot + direction
	
	if room_slot in dungeon.rooms:
		return generate_next_room(dungeon)

	var room = creator.create_room(room_slot)

	placer.place_room(room)
	dungeon.rooms[room_slot] = room
	generate_tunnel(dungeon, previous_room_slot, room_slot)

func generate_extra_tunnel(dungeon):
	pass

func generate_tunnel(dungeon, slot1, slot2):
	if [slot1, slot2] in dungeon.tunnels or [slot2, slot1] in dungeon.tunnels:
		return
	var direction = slot1 - slot2
	var tunnel
	if direction in [Vector2.UP, Vector2.DOWN]:
		tunnel = creator.create_v_tunnel(dungeon.rooms[slot1], dungeon.rooms[slot2])
		placer.place_v_tunnel(tunnel)
	else:
		tunnel = creator.create_h_tunnel(dungeon.rooms[slot1], dungeon.rooms[slot2])
		placer.place_h_tunnel(tunnel)
	dungeon.tunnels[[slot1, slot2]] = tunnel

