extends Control



func _ready():
	set_physics_process(true)

func _input(event):

	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER and get_parent().lose:

			get_node("PopupMenu").hide()
			get_parent()._reset()


