extends Node2D

func _ready():
	notify_systems($Player)

func notify_systems(e):
	get_tree().call_group("Systems", "recheck_entity", e)
