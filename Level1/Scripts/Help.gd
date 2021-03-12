extends Button

func _on_Help_pressed():
	$"../Popup/Help".set_global_position(
			Vector2(get_node("/root/Title/").position.x+50, 
			get_node("/root/Title/").position.y+30))
	$"../Popup/Help".show()
