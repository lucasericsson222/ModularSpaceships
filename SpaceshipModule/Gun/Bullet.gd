extends KinematicBody2D

var direction = PI/2
var speed = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	rotation = direction + PI/2
	move_and_collide(delta * Vector2(cos(direction) * speed, sin(direction) * speed))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
