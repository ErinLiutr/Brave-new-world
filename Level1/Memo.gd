extends Node2D

export var player_path = ""
var showing = false

var pressed = false
var counter = 0

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
	if name == "Memo":
		get_node("../DialogBox").show()
		get_node("../DialogBox")._start("152")
	else:
		get_node(player_path).canMove = true

