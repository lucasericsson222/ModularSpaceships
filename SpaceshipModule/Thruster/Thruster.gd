extends SpaceshipModule

export var myposition = Vector2(0,0)

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		
		var impulse_strength = 1
		var angle = global_rotation - PI/2
		myposition = $ThrustPosition.global_position - get_parent().position
		get_parent().add_force(myposition, Vector2(cos(angle), sin(angle)) * impulse_strength)

