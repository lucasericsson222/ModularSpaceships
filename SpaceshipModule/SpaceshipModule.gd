extends Node2D


class_name SpaceshipModule

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var totalHealth := 10.0
export var health: float
var checkingForInput = false
var defaultModulate = Color.white
var currentModulate = Color.white

# note this should only be called during physics process
func applyDamage():
	health -= 1
	currentModulate = defaultModulate.darkened((totalHealth-health)/totalHealth)
	if health <= 0:
		if !is_in_group("Player"):
			for m in get_parent().get_children():
				if m.has_method("checkSupport"):
					if ((m.position - position).length() == 60):
						m.checkSupport()
		queue_free()
	

func setHealth(h:float):
	health = h

func setTotalHealth(h:float)->void:
	totalHealth = h
# Called when the node enters the scene tree for the first time.
func _ready():
	health = totalHealth

func checkSupport():
	var number_of_supports = 0
	for m in get_parent().get_children():
		if m.has_method("checkSupport"):
			if (m.position - position).length() == 60:
				number_of_supports += 1
	if number_of_supports == 1:
		queue_free()
			

func selectedColor():
	if checkingForInput:
		$Sprite.modulate = Color.blue
	else:
		$Sprite.modulate = currentModulate

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
