extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var modules = get_children()
	for m in modules:
		m.modulate = Color.mediumorchid


func _process(delta):
	var modules = get_children()
	for m in modules:
		if m.is_in_group("Thruster"):
			controlThrusters(m)
		if m.is_in_group("Gun"):
			Input.action_press("Gun" + String(m.get_instance_id()))
			# fire if the player is in that direction
			pass

func controlThrusters(m):
	var player = get_tree().get_nodes_in_group("Player")
	var dotProduct = (player[0].global_position - global_position).dot(Vector2(cos(m.global_rotation + PI/2),sin(m.global_rotation + PI/2)))
	if m.position.y * m.position.x == 0:
		thrusterFireIf(dotProduct < 0, m)
	elif m.position.y < 0 and m.position.x != 0:
		thrusterFireIf(dotProduct <= 0, m)
	elif m.position.y >= 0 and m.position.x != 0:
		thrusterFireIf(dotProduct > 0, m)

func thrusterFireIf(shouldFire:bool, m) -> void:
	if shouldFire:
		Input.action_press("Thruster" + String(m.get_instance_id()))
	else:
		Input.action_release("Thruster" + String(m.get_instance_id()))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
