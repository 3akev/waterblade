extends Node2D

var required_components = []
var entities = []

func _init():
	Events.connect("spawned_entity", self, "recheck_entity")

func recheck_entity(entity):
	entities.erase(entity)
	for c in required_components:
		if entity.get_node(c) == null:
			return
	entities.append(entity)
