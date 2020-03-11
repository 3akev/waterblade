extends Node2D

func _init():
	Events.connect("spawn_entity", self, "on_spawn_entity")

func _ready():
	Events.emit_signal("spawn_entity", $Player)
	Events.emit_signal("spawned_player", $Player)

func on_spawn_entity(entity):
	add_child(entity)
	Events.emit_signal("spawned_entity", entity)
