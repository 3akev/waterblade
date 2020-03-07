extends Node2D

const DungeonGenerator = preload("res://Core/Dungeon/DungeonGenerator.gd")
const DungeonPlacer = preload("res://Core/Dungeon/DungeonPlacer.gd")

onready var tilemap = $TileMap
var rng = RandomNumberGenerator.new()
var dungeon
var placer

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	rng.randomize()
	dungeon = DungeonGenerator.new(rng).generate_dungeon()
	DungeonPlacer.new(tilemap).place_dungeon(dungeon)
