extends Node2D


func _input(event):
	if event is InputEventKey and event.scancode == KEY_B:
		$"Begin"._on_Button_Pressed()
	if event is InputEventKey and event.scancode == KEY_Q:
		$"Quit"._on_Button_Pressed()
	if event is InputEventKey and event.scancode == KEY_H:
		$"Help"._on_Help_pressed()
