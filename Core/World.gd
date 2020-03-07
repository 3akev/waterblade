extends Node2D

const DungeonGenerator = preload("res://Core/Dungeon/DungeonGenerator.gd")
onready var tilemap = $TileMap
var rng = RandomNumberGenerator.new()

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	rng.randomize()
	DungeonGenerator.new(rng, tilemap).generate_dungeon()
