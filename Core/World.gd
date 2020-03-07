extends Node2D

const Dungeon = preload("res://Core/Dungeon/Dungeon.gd")
onready var tilemap = $TileMap
var rng = RandomNumberGenerator.new()

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	rng.randomize()
	Dungeon.new(rng, tilemap).generate_dungeon()
