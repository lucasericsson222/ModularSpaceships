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
		var old_parent = get_parent()
		get_parent().remove_child(self)
		if old_parent.has_method("markChildren"):
			old_parent.markChildren()
		for m in old_parent.get_children():
			if m.has_method("destroyIfNotMarked"):
				m.destroyIfNotMarked()
		for m in old_parent.get_children():
			if m.has_method("markNeighbors"):
				m.mark = false
		if old_parent.has_method("markChildren"):
			old_parent.mark = false
		else:
			old_parent.queue_free()
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
	myPart.global_position = global_position
	myPart.global_rotation = global_rotation
	myPart.velocity = get_parent().linear_velocity
	var root = get_tree().get_root()
	self.position = Vector2(0,0)
	self.rotation = 0
	get_parent().remove_child(self)
	
	root.add_child(myPart)
	myPart.add_child(self)


func selectedColor():
	if checkingForInput:
		$Sprite.modulate = Color.blue
	else:
		$Sprite.modulate = currentModulate

func markNeighbors():
	if mark:
		return
	mark = true
	var modules = get_parent().get_children()
	for m in modules:
		if m.has_method("markNeighbors"):
			if m.mark: 
				continue
			if round(m.global_position.distance_to(global_position)) <= 60:
				m.markNeighbors()

func destroyIfNotMarked():
	if !mark:
		floatAway()
