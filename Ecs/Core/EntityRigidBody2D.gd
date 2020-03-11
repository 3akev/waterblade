extends RigidBody2D

signal integrate_forces(state)


func _integrate_forces(state):
	emit_signal("integrate_forces", state)
	state.integrate_forces()
