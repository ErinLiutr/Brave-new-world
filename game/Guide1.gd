extends Sprite

export var player_path = ""
export var scene_path = ""

export var id = 0

var showing = false

var pressed = false
var counter = 0

var started = false

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		pressed = true
	elif event.is_action_released("ui_cancel"):
		pressed = false

func _physics_process(delta):
	if showing:
		counter += 1
		if pressed and counter > 10:
			_stop_show()
	pressed = false

func _start_show():
	show()
	showing = true
	

func _stop_show():
	counter = 0
	hide()
	showing = false
	get_parent()._start_show2()
	
