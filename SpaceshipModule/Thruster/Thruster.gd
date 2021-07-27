extends SpaceshipModule

export var myposition = Vector2(0,0)
var checkingForInput = false
var thrustersOn = false

func _ready():
	InputMap.add_action("Thruster" + String(get_instance_id()))


func _physics_process(delta):
	
	if Input.is_action_pressed("Thruster" + String(get_instance_id())):
		$CPUParticles2D.emitting = true
		var impulse_strength = 2
		var angle = global_rotation - PI/2
		myposition = $ThrustPosition.global_position - get_parent().position
		get_parent().apply_impulse(myposition, Vector2(cos(angle), sin(angle)) * impulse_strength)

	else:
		$CPUParticles2D.emitting = false
func _unhandled_key_input(event):
	if checkingForInput:
		InputMap.action_erase_events("Thruster" + String(get_instance_id()))
		InputMap.action_add_event("Thruster" + String(get_instance_id()), event)
		print(event.as_text())
		print(InputMap.get_actions())
		checkingForInput = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
		
func on_click():
	checkingForInput = true

