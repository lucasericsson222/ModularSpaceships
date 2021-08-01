extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	$ViewportContainer/Viewport/Camera2D.make_current()
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	for i in range(int(get_viewport_rect().size.x / 60)):
		var color = Color.gray
		if i % 5 == 0:
			color = Color.white
		draw_line(Vector2(60 * i, 0), Vector2(60 * i, get_viewport_rect().size.y), color)
	for i in range(int(get_viewport_rect().size.y / 60)):
		var color = Color.gray
		if i % 5 == 0:
			color = Color.white
		draw_line(Vector2(0, 60 * i), Vector2(get_viewport_rect().size.x ,60 * i), color)

