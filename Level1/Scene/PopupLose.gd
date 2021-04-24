extends Control


var pressed = false

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(false)

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_interact"):
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false

func _physics_process(delta):
	if get_parent().lose:
		if pressed:
			get_node("PopupMenu").hide()
			get_parent()._reset()
			set_process_unhandled_key_input(false)
	pressed = false

