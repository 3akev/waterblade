extends "res://Ecs/Core/System.gd"

const SMF = preload("res://Core/StateMachine/StateMachineFactory.gd")

func _init():
	required_components = ["BehaviourComponent"]

func recheck_entity(entity):
	.recheck_entity(entity)
	if entity in entities and entity.get_node("StateMachine")  == null:
		var behaviour = entity.get_node("BehaviourComponent").behaviour.new()
		behaviour.config["target"] = entity
		entity.add_child(SMF.create(behaviour.config))
