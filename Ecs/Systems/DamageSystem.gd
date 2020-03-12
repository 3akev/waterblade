extends "res://Ecs/Core/System.gd"

func _init():
	._init()
	Events.connect("damage_entity", self, "on_damage_entity")
	
func on_damage_entity(entity, damage):
	assert(entity.get_node("HealthComponent") != null)
	assert(damage >= 0)
	var health = entity.get_node("HealthComponent")
	health.health -= damage
	if health.health <= 0:
		Events.emit_signal("kill_entity", entity)
	
