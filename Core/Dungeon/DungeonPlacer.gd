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
	
	for x in range(rect.position.x, rect.end.x + 1):
		tilemap.set_cell(x, rect.position.y, wall_index)
		tilemap.set_cell(x, rect.end.y, wall_index)
	for y in range(rect.position.y, rect.end.y + 1):
		tilemap.set_cell(rect.position.x, y, wall_index)
		tilemap.set_cell(rect.end.x, y, wall_index)

func place_h_tunnel(rect):
	place_floor(rect)
	
	for x in range(rect.position.x, rect.end.x + 1):
		tilemap.set_cell(x, rect.position.y, wall_index)
		tilemap.set_cell(x, rect.end.y, wall_index)

func place_v_tunnel(rect):
	place_floor(rect)
	
	for y in range(rect.position.y, rect.end.y + 1):
		tilemap.set_cell(rect.position.x, y, wall_index)
		tilemap.set_cell(rect.end.x, y, wall_index)

func place_floor(rect):
	for x in range(rect.position.x, rect.end.x + 1):
		for y in range(rect.position.y, rect.end.y + 1):
			tilemap.set_cell(x, y, floor_index)
