extends Node2D


class_name SpaceshipModule

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var floatingSpaceshipModuleScene = preload("./FloatingSpaceshipModule/FloatingSpaceshipModule.tscn")
export var totalHealth := 10.0
export var health: float
var checkingForInput = false
var defaultModulate = Color.white
var currentModulate = Color.white
var mark = false
# note this should only be called during physics process
func applyDamage():
	health -= 1
	currentModulate = defaultModulate.darkened((totalHealth-health)/totalHealth)
	if health <= 0:
		if get_parent().has_method("markChildren"):
			get_parent().markChildren()
		for m in get_parent().get_children():
			if m.has_method("destroyIfNotMarked"):
				m.destroyIfNotMarked()
		queue_free()




func setHealth(h:float):
	health = h

func setTotalHealth(h:float)->void:
	totalHealth = h
# Called when the node enters the scene tree for the first time.
func _ready():
	health = totalHealth


func floatAway():
	var myPart = floatingSpaceshipModuleScene.instance()
	myPart.position = global_position
	myPart.rotation = global_rotation
	var root = get_tree().get_root()
	get_parent().remove_child(self)
	
	root.add_child(myPart)
	myPart.add_child(self)
	var offset = myPart.global_position-get_parent().global_position
	myPart.apply_impulse(offset, offset)


func selectedColor():
	if checkingForInput:
		$Sprite.modulate = Color.blue
	else:
		$Sprite.modulate = currentModulate

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func markNeighbors():
	if mark:
		return
	mark = true
	for m in get_parent().get_children():
		if m.has_method("markNeighbors"):
			if (m.global_position - global_position).length() <= 61:
				
				m.markNeighbors()

func destroyIfNotMarked():
	if !mark:
		floatAway()
