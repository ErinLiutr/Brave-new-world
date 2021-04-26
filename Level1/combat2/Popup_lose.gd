extends Node2D

onready var enabled = false

func start():
	enabled = true
	
func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and enabled:
		print(get_parent().get_parent().name)
		get_parent().get_parent()._return(false)
		self.visible = false
		enabled = false
		
	if event is InputEventKey and event.scancode == KEY_ENTER and enabled:
		get_parent().get_parent()._restart()
		self.visible = false
		enabled = false
	
