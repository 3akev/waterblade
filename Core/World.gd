extends Node2D

onready var tilemap = $TileMap

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	#create two rooms
	var room1 = Rect2(2, 2, 10, 15)
	var room2 = Rect2(50, 15, 10, 15)
	create_room(room1)
	create_room(room2)

func create_room(rect):
	# place walls around the room
	var floor_index = tilemap.tile_set.find_tile_by_name("Floor")
	var wall_index = tilemap.tile_set.find_tile_by_name("Wall")
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
