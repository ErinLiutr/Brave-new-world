extends NinePatchRect

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
	labels = get_node("Labels").get_children()

func _handle_interaction():
	if currentLabel == 0:
		open = false
		_close_menu()
		get_parent().get_node("Inventory")._start_show()
	elif currentLabel == 1:
		$"../../../../../Room".load_game()
		open = false
		_close_menu()
	elif currentLabel == 2:
		$"../../../../../Room".save_game()
		open = false
		_close_menu()
	elif currentLabel == 3:	
		get_node("/root/Room/YSort/Player").canMove = false
		$"../Help/Help".set_global_position(
			Vector2(get_node("/root/Room/YSort/Player").position.x-80, 
			get_node("/root/Room/YSort/Player").position.y-70))
		$"../Help/Help".show()
		hide()
		for child in labels:
			child.get_node("arrow").hide()
	elif currentLabel == 4:
		get_tree().change_scene("res://title.tscn")
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
		if key_event.is_action_pressed("ui_menu"):
			menu = true
		elif key_event.is_action_released("ui_menu"):
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
	get_node("/root/Room/YSort/Player").canMove = false
	menu = false
	open = true
	
func _close_menu():
	hide()
	for child in labels:
		child.get_node("arrow").hide()
	get_node("/root/Room/YSort/Player").canMove = true
	open = false
