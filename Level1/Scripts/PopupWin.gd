extends Control

func _ready():
	pass # Replace with function body.
	
func _input(event):
	if event is InputEventKey and event.scancode == KEY_C:
		print("switch back")
