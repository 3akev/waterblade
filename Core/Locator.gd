extends Node

var dungeon = null setget set_dungeon, get_dungeon
var player = null setget set_player, get_player

func _init():
	Events.connect("generated_dungeon", self, "_on_generated_dungeon")
	Events.connect("spawned_player", self, "_on_spawned_player")

func _on_generated_dungeon(_dungeon):
	dungeon = _dungeon

func _on_spawned_player(_player):
	player = _player

func set_dungeon(value): pass
func get_dungeon(): return dungeon

func set_player(value): pass
func get_player(): return player

