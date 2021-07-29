extends Node2D


class_name SpaceshipModule

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var health := 10.0


func applyDamage():
	health -= 5
	if health <= 0:
		queue_free()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
