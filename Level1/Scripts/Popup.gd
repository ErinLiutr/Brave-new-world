extends Control

var choice_item = preload("res://Choice.tscn")

func _input(event):
	if event is InputEventKey and event.scancode == KEY_Q:
		get_parent().get_parent()._return(false)
	if event is InputEventKey and event.scancode == KEY_R:
		get_parent().get_parent()._restart()
