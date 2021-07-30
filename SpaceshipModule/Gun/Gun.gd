extends SpaceshipModule

class_name Gun

var gunDamage = 10
onready var bulletScene = preload("./Bullet.tscn")



func _ready():
	InputMap.add_action("Gun" + String(get_instance_id()))
	var event = InputEventKey.new()
	event.scancode = KEY_SPACE
	event.pressed = false
	InputMap.action_add_event("Gun" + String(get_instance_id()), event)
	._ready()

func _process(_delta):
	if (Input.is_action_pressed("Gun" + String(get_instance_id()))):
		fire()
	selectedColor()






func _unhandled_key_input(event):
	if checkingForInput:
		InputMap.action_erase_events("Gun" + String(get_instance_id()))
		InputMap.action_add_event("Gun" + String(get_instance_id()), event)
		print(event.as_text())
		print(InputMap.get_actions())
		checkingForInput = false

func setBulletAlignment(bullet):
	if get_parent().is_in_group("Evil"):
		bullet.collision_layer = 0b0000000000000001
		bullet.collision_mask = 0b00000000000000001

func fire():
	var bulletInstance = bulletScene.instance()
	bulletInstance.global_transform = global_transform
	bulletInstance.direction = global_rotation - PI/2
	bulletInstance.launcherVelocity = get_parent().linear_velocity
	setBulletAlignment(bulletInstance)
	get_tree().get_root().add_child(bulletInstance)
	


