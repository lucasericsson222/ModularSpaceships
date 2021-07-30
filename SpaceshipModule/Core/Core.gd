extends SpaceshipModule

 
# all movement will be applied to the core
# maybe i'll make it so that the individual thrusters get the input, but then the question
# is how to apply the input: I could try using rigidbodies and creating a single rigid
# body for the entire thing? then applying torque to certian areas
# or maybe make each spaceship module a rigidbody and then apply the torche to that part
# actually::: use one rigidbody, and all the rest are spawned below
# best idea yet

var grid = []
var width = 5
var height = 5


func _ready():
	# initialize spaceship array
	for i in range(width):
		grid.append([])
		for j in range(height):
			if (i == ceil(width/2) && j == ceil(height/2)): # if is the middle
				grid[i].append(self) # put the core
			else: 
				grid[i].append(0)
	

func markChildren():
	mark = true
	var modules = get_children()
	for m in modules:
		if m.has_method("setHealth"):
			if (m.global_position - global_position).length() <= 61:
				m.markNeighbors()
