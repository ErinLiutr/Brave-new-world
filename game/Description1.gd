extends Sprite

var player_path

var showing = false

var pressed = false
var counter = 0

func _ready():
	player_path = get_parent().player_path
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
	for node in get_children():
		if node.name != "Choices":
			node.hide()
	hide()
	showing = false
	get_node("Choices").close()
	if get_parent().name == "Camera2D":
		get_node(player_path).canMove = true
	else:
		get_parent().get_node("NinePatchRect/GridContainer").showing = true
		get_parent().showing = true
