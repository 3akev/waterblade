extends Node2D

const DungeonGenerator = preload("res://Core/Dungeon/DungeonGenerator.gd")
onready var tilemap = $TileMap
var rng = RandomNumberGenerator.new()
var dungeon

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	rng.randomize()
	dungeon = DungeonGenerator.new(rng, tilemap).generate_dungeon()
