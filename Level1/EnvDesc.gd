extends Sprite

export var player_path = ""
var showing = false

var pressed = false
var counter = 0

func _ready():
	get_node("Choices/GridContainer").init()
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
	showing = true

func _stop_show():
	counter = 0
	get_node("Choices/Description").text = ""
	hide()
	showing = false
	print("4")
	get_node(player_path).canMove = true
