extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func handle_selection(destination):
	get_parent().get_parent()._stop_show()
	if destination == "slidingPuzzle":
		get_node("/root/Room/YSort/Player/Camera2D/blur").show()
		get_node("/root/Room/YSort/Player/Camera2D/Puzzle")._start_show()
		get_node("/root/Room/YSort/Player").canMove = false
