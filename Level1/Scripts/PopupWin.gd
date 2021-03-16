extends Control

func _ready():
	pass # Replace with function body.
	
func _input(event):
	if event is InputEventKey and event.scancode == KEY_C:
		get_parent().get_parent()._return(true)
