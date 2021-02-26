extends Label

var showing = false

var pressed = false
var counter = 0

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	
func _unhandled_key_input(event):
	if event.is_action_pressed("ui_interact"):
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false
		
func _physics_process(delta):
	if showing:
		counter += 1
		if pressed and counter > 10:
			counter = 0
			hide()
			get_parent().hide()
			showing = false
			get_node("/root/Room/YSort/Player").canMove = true
	pressed = false

func _start_show():
	showing = true
