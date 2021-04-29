extends Node2D
var txtLabel

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

func _on_LineEdit_text_entered(new_text):
	txtLabel = get_node("LineEdit").text

func _physics_process(delta):
	if showing:
		counter += 1
		if pressed and counter > 10:
			_stop_show()
		if (txtLabel == "7031"):
			_stop_show()
			get_node("/root/2ndfloor/YSort/table/computer/Interact").id = "408-2"
	pressed = false
	
	
func _stop_show():
	showing = false
	hide()
	get_node(player_path + "/Camera2D/blur").hide()
	get_node(player_path).canMove = true
	
	
func _start_show():
	showing = true
	show()
	get_node("LineEdit").text = ""
	
