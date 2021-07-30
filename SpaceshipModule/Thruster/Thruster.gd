extends SpaceshipModule

export var myposition = Vector2(0,0)
var thrustersOn = false
export var impulse_strength = 2 # if need to increase thruster speed
func _ready():
	InputMap.add_action("Thruster" + String(get_instance_id()))
	var event = InputEventKey.new()
	var myscancode = KEY_SPACE
	if rotation_degrees == 0:
		myscancode = KEY_W
	event.scancode = myscancode
	event.pressed = false
	InputMap.action_add_event("Thruster" + String(get_instance_id()), event)

func _physics_process(_delta):
	
	# fire the thrusters
	if Input.is_action_pressed("Thruster" + String(get_instance_id())):
		$CPUParticles2D.emitting = true # style wooo
		var angle = global_rotation - PI/2
		myposition = $ThrustPosition.global_position - get_parent().position
		get_parent().apply_impulse(myposition, Vector2(cos(angle), sin(angle)) * impulse_strength)
	else:
		$CPUParticles2D.emitting = false

func _process(_delta):
	clickColor()

func clickColor():
	selectedColor()

func _unhandled_key_input(event):
	if checkingForInput:
		# clear and place in new event for input
		InputMap.action_erase_events("Thruster" + String(get_instance_id()))
		InputMap.action_add_event("Thruster" + String(get_instance_id()), event)
		
		# debug code
		print(event.as_text())
		print(InputMap.get_actions())
		
		# stop checking for input
		checkingForInput = false

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	# get if user clicked on this module
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
		
func on_click():
	# if statement -> make sure not ai, because we don't want the player to be 
	# able to change the controls of the enemy ships
	if !get_parent().is_in_group("Evil"):
		# alternate checking for input, so you can turn on and off the checking
		# for input
		checkingForInput = !checkingForInput

