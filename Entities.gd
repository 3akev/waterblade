extends Node2D

var Player = preload("res://Ecs/Entities/Player.tscn")

func _ready():
	var player = Player.instance()
	add_child(player)
	notify_systems(player)

func notify_systems(e):
	get_tree().call_group("Systems", "recheck_entity", e)
