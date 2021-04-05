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
			if get_parent().name == "Camera2D":
				get_node(player_path).canMove = true
			_stop_show()
	pressed = false

func _start_show():
	show()
	showing = true
	

func _stop_show():
	if id == 0:
		if !started and scene_path == "/root/Prologue":
			get_node(scene_path)._start()
			started = true
	elif id == 3:
		get_node(player_path).canMove = false
		get_node("../Inventory").showing = true
		get_node("../Inventory/NinePatchRect/GridContainer").showing = true
	counter = 0
	hide()
	showing = false
