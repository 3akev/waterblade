# State ID
var id = "" setget set_id

# Target for the state (object, node, etc)
var target = null setget set_target

# Reference to state machine
var state_machine = null setget set_state_machine

func set_id(value):
	id = value

func set_target(value):
	target = value

func set_state_machine(value):
	state_machine = value

func _ready():
	pass

# State machine callback called during transition when entering this state
func _on_enter_state(): pass

# State machine callback called during transition when leaving this state
func _on_leave_state(): pass
