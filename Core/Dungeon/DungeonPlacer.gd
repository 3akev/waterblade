extends Node

var tilemap
var floor_index
var wall_index

func _init(_tilemap):
	tilemap = _tilemap
	floor_index = tilemap.tile_set.find_tile_by_name("Floor")
	wall_index = tilemap.tile_set.find_tile_by_name("Wall")

func place_room(rect):
	place_floor(rect)
	# place walls around the room
	for x in range(rect.position.x, rect.end.x + 1):
		tilemap.set_cell(x, rect.position.y, wall_index)
		tilemap.set_cell(x, rect.end.y, wall_index)
	for y in range(rect.position.y, rect.end.y + 1):
		tilemap.set_cell(rect.position.x, y, wall_index)
		tilemap.set_cell(rect.end.x, y, wall_index)

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

func place_floor(rect):
	for x in range(rect.position.x + 1, rect.end.x):
		for y in range(rect.position.y + 1, rect.end.y):
			tilemap.set_cell(x, y, floor_index)