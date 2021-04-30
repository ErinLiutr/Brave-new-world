extends Control

var pressed = false

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_interact"):
		print("pressed")
		pressed = true
	elif event.is_action_released("ui_interact"):
		print("none")
		pressed = false
	
func _physics_process(delta):
	if get_parent().get_parent().get_node("Password").lose:
		if pressed:
			print("pressed")
			get_node("PopupMenu").hide()
			get_node("/root/Room/YSort/Player/Camera2D/Password")._reset()
	pressed = false

