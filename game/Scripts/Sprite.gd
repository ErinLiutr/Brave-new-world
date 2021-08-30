extends Sprite

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var spawnArea = Rect2(0, 0, 10, 10)
			draw_rect(spawnArea, Color(0.2, 0.2, 1.0, 0.5))
