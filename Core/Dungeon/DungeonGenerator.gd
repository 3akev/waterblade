extends Node

const DungeonCreator = preload("res://Core/Dungeon/DungeonCreator.gd")
const Dungeon = preload("res://Core/Dungeon/Dungeon.gd")

var rng
var creator

func _init(_rng):
	rng = _rng
	creator = DungeonCreator.new(rng)

func generate_dungeon():
	var dungeon = Dungeon.new()
	dungeon.add_room(Vector2(0, 0), creator.create_room(Vector2(0, 0)))
	
	var num_rooms = rng.randi_range(Constants.MIN_ROOMS_PER_DUNGEON, Constants.MAX_ROOMS_PER_DUNGEON) - 1
	for _i in range(num_rooms):
		generate_next_room(dungeon)
	
	var num_extra_tunnels = rng.randi_range(Constants.MIN_EXTRA_TUNNELS, Constants.MAX_EXTRA_TUNNELS)
	for _i in range(num_extra_tunnels):
		generate_extra_tunnel(dungeon)
	
	return dungeon

func generate_next_room(dungeon):
	var previous_slot = dungeon.get_random_room()
	var slot = dungeon.get_adjacent_space(previous_slot)
	
	if slot == null:
		return generate_next_room(dungeon)

	dungeon.add_room(slot, creator.create_room(slot))
	generate_tunnel(dungeon, previous_slot, slot)

func generate_extra_tunnel(dungeon):
	var slot1 = dungeon.get_random_room()
	var slot2 = dungeon.get_adjacent_non_connected_room(slot1)
	
	if slot2 == null:
		return
	
	generate_tunnel(dungeon, slot1, slot2)

func generate_tunnel(dungeon, slot1, slot2):
	var direction = slot1 - slot2
	var tunnel
	if direction in [Vector2.UP, Vector2.DOWN]:
		tunnel = creator.create_v_tunnel(dungeon.rooms[slot1], dungeon.rooms[slot2])
	else:
		tunnel = creator.create_h_tunnel(dungeon.rooms[slot1], dungeon.rooms[slot2])
	dungeon.add_tunnel([slot1, slot2], tunnel)

