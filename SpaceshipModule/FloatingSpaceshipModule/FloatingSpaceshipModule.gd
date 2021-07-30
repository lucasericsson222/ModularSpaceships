extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	apply_central_impulse(velocity)

var numberOfPhysicsProcess = 0
func _physics_process(delta):
	if numberOfPhysicsProcess == 0:
		numberOfPhysicsProcess += 1
		apply_torque_impulse(rand_range(-1000, 1000))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
