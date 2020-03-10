extends Node

const IdleState = preload("res://Core/States/IdleState.gd")
const ChaseState = preload("res://Core/States/ChaseState.gd")

var config = {
  "target": null,
  "current_state": "idle",
  "states": [
	{"id": "idle", "state": IdleState},
	{"id": "chase", "state": ChaseState}
  ],
  "transitions": [
	{"state_id": "idle", "to_states": ["chase"]},
	{"state_id": "chase", "to_states": ["idle"]}
  ]
}
