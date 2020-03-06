extends Node

var required_components = []
var entities = []

func recheck_entity(entity):
	entities.erase(entity)
	for c in required_components:
		if entity.get_node(c) == null:
			return
	entities.append(entity)
