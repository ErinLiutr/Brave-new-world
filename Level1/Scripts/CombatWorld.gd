extends Node2D
var started = false

func _input(event):
	if event is InputEventKey and event.scancode == KEY_C:
		$"YSort/Enemy".life_points = 0
