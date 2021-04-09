extends Sprite

var prologue_scene = preload("res://Prologue.tscn")
var room_scene = preload("res://Room.tscn")
var epilogue_scene = preload("res://Epilogue.tscn")


var menu = false
var open = false

var up = false
var down = false

var currentLabel = 0
var labels

var pointer

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	labels = get_node("NinePatchRect/Chapters").get_children()

func _handle_interaction():
	if currentLabel == 0:
		open = false
		_close_menu()
		var TheRoot = get_node("/root")
		var this_scene = TheRoot.get_node("Title")
		var next_scene = prologue_scene.instance()
		next_scene.title_scene = this_scene
		next_scene.get_node("YSort/Player/Camera2D/Guide")._start_show()
		next_scene.get_node("YSort/Player").canMove = false
		next_scene.get_node("YSort/Player/Camera2D/Sound/NinePatchRect/HSlider").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
		TheRoot.remove_child(this_scene)
		TheRoot.add_child(next_scene)
	elif currentLabel == 1:
		open = false
		_close_menu()
		var TheRoot = get_node("/root")
		var this_scene = TheRoot.get_node("Title")
		var next_scene = room_scene.instance()
		next_scene.title_scene = this_scene
		next_scene.get_node("YSort/Player").canMove = false
		next_scene.get_node("YSort/Player/Camera2D/Sound/NinePatchRect/HSlider").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
		next_scene.get_node("YSort/Player/Camera2D/Inventory").item_ids = ["101", "102", "103", "104"]
		TheRoot.remove_child(this_scene)
		TheRoot.add_child(next_scene)
		next_scene.get_node("YSort/Player/Camera2D/Chapter1")._play_fadeout()
	elif currentLabel == 2:
		open = false
		_close_menu()
		var TheRoot = get_node("/root")
		var this_scene = TheRoot.get_node("Title")
		var next_scene = epilogue_scene.instance()
		next_scene.title_scene = this_scene
		TheRoot.remove_child(this_scene)
		TheRoot.add_child(next_scene)
		next_scene._start("49")
	elif currentLabel == 3:
		open = false
		_close_menu()
		var TheRoot = get_node("/root")
		var this_scene = TheRoot.get_node("Title")
		var next_scene = epilogue_scene.instance()
		next_scene.title_scene = this_scene
		TheRoot.remove_child(this_scene)
		TheRoot.add_child(next_scene)
		next_scene._start("69")
	else:
		open = false
		_close_menu()

func _physics_process(delta):
	if open:
		if Input.is_action_pressed("ui_interact"):
			_handle_interaction()
		if menu:
			_close_menu()
		if up:
			labels[currentLabel].get_node("arrow").hide()
			if currentLabel == 0:
				currentLabel = labels.size()-1
			else:
				currentLabel-=1
			labels[currentLabel].get_node("arrow").show()		
		if down:
			labels[currentLabel].get_node("arrow").hide()
			if currentLabel == labels.size()-1:
				currentLabel = 0
			else:
				currentLabel+=1
			labels[currentLabel].get_node("arrow").show()
			
		menu = false
		up = false
		down = false

func _unhandled_key_input(key_event):
	if open:
		if key_event.is_action_pressed("ui_cancel"):
			menu = true
		elif key_event.is_action_released("ui_cancel"):
			menu = false
		if key_event.is_action_pressed("ui_down"):
			down = true
		elif key_event.is_action_released("ui_down"):
			down = false
		if key_event.is_action_pressed("ui_up"):
			up = true
		elif key_event.is_action_released("ui_up"):
			up = false

func _open_menu():
	show()
	currentLabel = 0
	labels[0].get_node("arrow").show()
	menu = false
	open = true
	
func _close_menu():
	hide()
	for child in labels:
		child.get_node("arrow").hide()
	open = false
