extends Node2D

func _init():
	Events.connect("spawn_entity", self, "on_spawn_entity")

func _ready():
	notify_systems($Player)

func on_spawn_entity(entity):
	add_child(entity)
	notify_systems(entity)

func notify_systems(e):
	get_tree().call_group("Systems", "recheck_entity", e)
