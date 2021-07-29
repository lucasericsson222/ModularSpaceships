extends Node2D


class_name SpaceshipModule

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var totalHealth := 10.0
export var health: float
var checkingForInput = false
var defaultModulate = Color.white
func applyDamage():
	health -= 1
	defaultModulate = Color.white.darkened((totalHealth-health)/totalHealth)
	if health <= 0:
		queue_free()
	

func setHealth(h:float):
	health = h

func setTotalHealth(h:float)->void:
	totalHealth = h
# Called when the node enters the scene tree for the first time.
func _ready():
	health = totalHealth

func selectedColor():
	if checkingForInput:
		modulate = Color.blue
	else:
		if !get_parent().is_in_group("Evil"):
			modulate = defaultModulate

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
