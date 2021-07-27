extends SpaceshipModule

class_name Gun


var gunDamage = 10
onready var bulletScene = preload("./Bullet.tscn")
var checkingForInput = false


func _ready():
	InputMap.add_action("Gun" + String(get_instance_id()))

func _process(delta):
	if (Input.is_action_pressed("Gun" + String(get_instance_id()))):
		fire()
	if checkingForInput:
		modulate = Color.red
	else:
		modulate = Color.white

func _unhandled_key_input(event):
	if checkingForInput:
		InputMap.action_erase_events("Gun" + String(get_instance_id()))
		InputMap.action_add_event("Gun" + String(get_instance_id()), event)
		print(event.as_text())
		print(InputMap.get_actions())
		checkingForInput = false


func fire():
	var bulletInstance = bulletScene.instance()
	bulletInstance.global_transform = global_transform
	bulletInstance.direction = global_rotation - PI/2
	get_tree().get_root().add_child(bulletInstance)
