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
	get_node(player_path).canMove = true
	var invent_node = get_node(player_path + "/Camera2D/Inventory")
	if (!invent_node.item_ids.has("414")):
		invent_node.item_ids.append("414")
		if invent_node.item_ids.has("402") and invent_node.item_ids.has("410") and invent_node.item_ids.has("414"):
			get_node(player_path).canMove = false
			get_node(player_path + "/Camera2D/DialogBox").show()
			get_node(player_path + "/Camera2D/DialogBox")._start("150")
