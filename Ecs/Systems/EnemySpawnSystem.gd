extends "res://Ecs/Core/System.gd"

const Enemy = preload("res://Ecs/Entities/Brute.tscn")

onready var tilemap = get_tree().current_scene.get_node("World/TileMap")

func _init():
	._init()
	Events.connect("generated_dungeon", self, "on_generated_dungeon")
	
func on_generated_dungeon(dungeon):
	for slot in dungeon.rooms:
		var room = map2world(dungeon.rooms[slot])
		var num_enemies = randi() % (Constants.MAX_ENEMIES_PER_ROOM - Constants.MIN_ENEMIES_PER_ROOM) + Constants.MIN_ENEMIES_PER_ROOM 
		for _i in num_enemies:
			var enemy = Enemy.instance()
			enemy.position = Vector2(rand_range(room.position.x, room.end.x), rand_range(room.position.y, room.end.y))
			Events.emit_signal("spawn_entity", enemy)
		
func map2world(rect):
	return Rect2(tilemap.map_to_world(rect.position + Vector2(1, 1)), tilemap.map_to_world(rect.size - Vector2(2, 2)))
