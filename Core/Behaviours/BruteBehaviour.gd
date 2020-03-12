extends Node

const IdleState = preload("res://Core/States/IdleState.gd")
const ChaseState = preload("res://Core/States/ChaseState.gd")
const WanderState = preload("res://Core/States/WanderState.gd")

var config = {
  "target": null,
  "current_state": "idle",
  "states": [
	{"id": "idle", "state": IdleState},
	{"id": "chase", "state": ChaseState},
	{"id": "wander", "state": WanderState}
  ],
  "transitions": [
	{"state_id": "idle", "to_states": ["chase", "wander"]},
	{"state_id": "chase", "to_states": ["idle"]},
	{"state_id": "wander", "to_states": ["idle"]}
  ]
}
