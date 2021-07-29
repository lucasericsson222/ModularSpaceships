extends KinematicBody2D

var direction = PI/2
var speed = 2000
var launcherVelocity = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	rotation = direction + PI/2
	var collision = move_and_collide(delta * (Vector2(cos(direction) * speed, sin(direction) * speed) + launcherVelocity ), false)
	if collision:
		if collision.collider_shape.has_method("applyDamage"):
			collision.collider_shape.applyDamage()
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
