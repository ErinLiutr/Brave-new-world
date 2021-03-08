extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func handle_selection(destination, path, id, picture, combine_to):
	get_parent().get_parent()._start(destination)
