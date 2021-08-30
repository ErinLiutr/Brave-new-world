extends Control

var pressed = false

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			if get_parent().lose:
				get_tree().change_scene("res://image_password/image_password.tscn")
