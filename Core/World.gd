extends Node2D

const DungeonGenerator = preload("res://Core/Dungeon/DungeonGenerator.gd")
const DungeonPlacer = preload("res://Core/Dungeon/DungeonPlacer.gd")

onready var tilemap = $TileMap
var rng = RandomNumberGenerator.new()
var dungeon

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	rng.randomize()
	dungeon = DungeonGenerator.new(rng).generate_dungeon()
	DungeonPlacer.new(tilemap).place_dungeon(dungeon)
	Events.emit_signal("generated_dungeon",  get_scaled_dungeon())

func get_scaled_dungeon():
	var d = {"rooms": {}, "tunnels": {}}
	for slot in dungeon.rooms:
		d.rooms[slot] = map_to_world(dungeon.rooms[slot])
	for slot in dungeon.tunnels:
		d.tunnels[slot] = map_to_world(dungeon.tunnels[slot])
	return d

func map_to_world(rect):
	return Rect2(tilemap.map_to_world(rect.position), tilemap.map_to_world(rect.size))
