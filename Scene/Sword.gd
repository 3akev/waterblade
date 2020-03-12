extends RayCast2D

const MovementControl = preload("res://Core/Utils/MovementControl.gd")

onready var sprite = $Sprite
onready var tip = $Position2D

var velocity
var previous_pos
var collider = null
var old_collider = null

func scale_sword():
	sprite

func _physics_process(delta):
	old_collider = collider
	collider = get_collider()
	
	if Input.is_action_just_pressed("sword_swing"):
		position = Vector2(0, 0)
		previous_pos = tip.global_position
	
	elif Input.is_action_just_released("sword_swing"):
		velocity = 0
		position = Vector2(5, -5)
		rotation = PI/4
		scale_sword()
	
	if Input.is_action_pressed("sword_swing"):
		var direction = MovementControl.get_movement_from_actions("sword_up", "sword_right", "sword_down", "sword_left")
		
		var prev_rotation = rotation
		rotation = lerp_angle(rotation, direction.angle() - PI/2, 0.2)
		
		velocity = (tip.global_position - previous_pos).length()
		
		previous_pos = tip.global_position
		scale_sword()
		
		if is_colliding() and collider != old_collider:
			var damage = Constants.BASE_SWORD_DAMAGE
			damage += velocity * Constants.SWORD_DAMAGE_VELOCITY_MULT
			Events.emit_signal("damage_entity", collider, floor(damage))
