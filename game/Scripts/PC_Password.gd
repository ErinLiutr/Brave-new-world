extends Node2D
var txtLabel

export var player_path = ""
var showing = false

var pressed = false
var counter = 0
var lose = false
var win = false

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		pressed = true
	elif event.is_action_released("ui_cancel"):
		pressed = false
#
func _on_LineEdit_text_entered(new_text):
	txtLabel = get_node("LineEdit").text
	if showing:
		$LineEdit.focus_mode = Control.FOCUS_NONE
		if (txtLabel == "7013"):
			_stop_show()
			$win/PopupMenu.rect_global_position = Vector2(get_parent().get_parent().global_position.x - 48, get_parent().get_parent().global_position.y - 44)
			$win.set_process_unhandled_key_input(true)
					
			get_node("win/PopupMenu").show()
			get_node("/root/2ndfloor/YSort/table/computer/Interact").id = "408-2"
			win = true
		else:
			#$lose.focus_mode = Control.FOCUS_ALL
			$lose/PopupMenu.rect_global_position = Vector2(get_parent().get_parent().global_position.x - 48, get_parent().get_parent().global_position.y - 44)
			get_node("lose/PopupMenu").show()
			showing = false
			self.z_index = 0
			lose = true

func _physics_process(delta):
	if showing:
		counter += 1
		if pressed and counter > 10:
			_stop_show()
#		if (txtLabel == "7013"):
#			_stop_show()
#			get_node("/root/2ndfloor/YSort/table/computer/Interact").id = "408-2"
#		if (txtLabel != "7013"):
#			get_node("lose/PopupMenu").popup()
#			lose = true
	pressed = false

func _stop_show():
	showing = false
	hide()
	get_node(player_path + "/Camera2D/blur").hide()
	get_node(player_path).canMove = true
	
	
func _start_show():
	showing = true
	$LineEdit.focus_mode = Control.FOCUS_ALL
	show()
	get_node("LineEdit").text = ""
	
func _reset():
	counter = 0
	$LineEdit.focus_mode = Control.FOCUS_ALL
	win = false
	showing = true
	lose = false
	self.z_index = 1
	set_physics_process(true)
	get_node("LineEdit").text = ""
	

