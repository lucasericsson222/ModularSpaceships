extends Gun


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	._process(delta)
	var turretDirection = get_angle_to(get_global_mouse_position()) + PI/2
	$turningTurretHead.rotation = turretDirection
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func fire() -> void:
	if ( not $fireTimer.is_stopped()):
		return
	var bulletInstance = bulletScene.instance()
	bulletInstance.global_transform = global_transform
	bulletInstance.direction = $turningTurretHead.global_rotation - PI/2
	bulletInstance.launcherVelocity = get_parent().linear_velocity
	get_tree().get_root().add_child(bulletInstance)
	$fireTimer.start()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
		
func on_click():
	checkingForInput = !checkingForInput

