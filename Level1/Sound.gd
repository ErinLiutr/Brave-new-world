extends Sprite

export var player_path = ""

var pressed = false
var showing = false

var left = false
var right = false

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	
func _physics_process(delta):
	if showing:
		if pressed:
			_close()
		if left:
			get_node("NinePatchRect/HSlider").value -= 5
		if right:
			get_node("NinePatchRect/HSlider").value += 5
			
		pressed = false
		left = false
		right = false

func _unhandled_key_input(key_event):
	if showing:
		if key_event.is_action_pressed("ui_cancel"):
			pressed = true
		elif key_event.is_action_released("ui_cancel"):
			pressed = false
		if key_event.is_action_pressed("ui_left"):
			left = true
		elif key_event.is_action_released("ui_left"):
			left = false
		if key_event.is_action_pressed("ui_right"):
			right = true
		elif key_event.is_action_released("ui_right"):
			right = false
			
func _open():
	showing = true
	show()
	
func _close():
	showing = false
	hide()
	if get_parent().name == "Camera2D":
		get_node(player_path).canMove = true


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
