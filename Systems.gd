extends Node2D

func recheck_entity(entity):
	for system in get_children():
		system.recheck_entity(entity)
