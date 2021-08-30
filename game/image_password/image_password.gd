extends Node2D

var stats = [1, 1, 1, 1]
var answer = [1, 0, 2, 3] # minus 1
var images = ["res://image_password/images/1.png", "res://image_password/images/2.png", 
"res://image_password/images/3.png", "res://image_password/images/4.png"]
var cur = 0
var highlight = Color(1, 0, 0, 1)#Color(206, 172, 172, 255)
var normal = Color( 1, 1, 1, 1 )#Color(102, 74, 74, 255)
var lose = false
var win = false
var showing = false
var counter = 0
var pressed = false
var cancel = false
export var player_path = ""
func _ready():
	get_node("Screen/pic1").texture = load(images[0])
	get_node("Screen/pic2").texture = load(images[0])
	get_node("Screen/pic3").texture = load(images[0])
	get_node("Screen/pic4").texture = load(images[0])
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	
func _unhandled_key_input(event):
	if event.is_action_pressed("ui_interact"):
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false
	if event.is_action_pressed("ui_cancel"):
		cancel = true
	elif event.is_action_released("ui_cancel"):
		cancel = false

func _physics_process(delta):
	if showing:
		counter += 1
		# set the box color
		if cancel:
			_stop_show()
			get_node(player_path).canMove = true
		if pressed and counter > 10:
			if (stats == answer):
				win = true
				#self.z_index = 0
				$Screen.hide()
				$win/win/PopupMenu.rect_global_position = Vector2(get_parent().get_parent().global_position.x - 48, get_parent().get_parent().global_position.y - 44)
				$win/win.set_process_unhandled_key_input(true)
				$win/win/PopupMenu.show()
				set_physics_process(false)
			else:
				print("Wrong!")
				lose = true
				#self.z_index = 0
				$Screen.hide()
				$lose/lose/PopupMenu.rect_global_position = Vector2(get_parent().get_parent().global_position.x - 48, get_parent().get_parent().global_position.y - 44)
				$lose/lose.set_process_unhandled_key_input(true)
				$lose/lose/PopupMenu.show()
				print($lose/lose/PopupMenu.rect_global_position)
				set_physics_process(false)
		if 0 == cur:
			$Screen/select1.visible = true
	#		$"rec1".color = highlight
		else:
			$Screen/select1.visible = false
	#		$"rec1".color = normal
		if 1 == cur:
			$Screen/select2.visible = true
	#		$"rec2".color = highlight
		else:
			$Screen/select2.visible = false
	#		$"rec2".color = normal
		if 2 == cur:
			$Screen/select3.visible = true
	#		$"rec3".color = highlight
		else:
			$Screen/select3.visible = false
	#		$"rec3".color = normal
		if 3 == cur:
			$Screen/select4.visible = true
	#		$"rec4".color = highlight
		else:
			$Screen/select4.visible = false
	#		$"rec4".color = normal			
	pressed = false
	cancel = false
		
func _reset():
	counter = 0
	self.z_index = 5
	win = false
	lose = false
	#stats = [1, 1, 1, 1]
	cur = 0
	set_physics_process(true)

func _input(event):
	if showing:
		if event is InputEventKey:
			if event.pressed and event.scancode == KEY_UP:
				$Screen/up.visible = true
				$Screen/up/Timer.start()
				var new_idx = (stats[cur]-1)
				if (new_idx < 0):
					new_idx = 3
				if (new_idx > 3):
					new_idx = 0
				print(new_idx)
				stats[cur] = new_idx
				get_node("Screen/pic%d"%(cur+1)).texture = load(images[new_idx-1])

		if event is InputEventKey:
			if event.pressed and event.scancode == KEY_DOWN:
				$Screen/down.visible = true
				$Screen/down/Timer.start()
				var new_idx = (stats[cur]+1) % 4
				if (new_idx < 0):
					new_idx = 3
				if (new_idx > 3):
					new_idx = 0
				stats[cur] = new_idx
				get_node("Screen/pic%d"%(cur+1)).texture = load(images[new_idx-1])

		if event is InputEventKey:
			if event.pressed and event.scancode == KEY_LEFT:
				$Screen/left.visible = true
				$Screen/left/Timer.start()
				cur = (cur-1) % 4
				if (cur == -1):
					cur = 3
		if event is InputEventKey:
			if event.pressed and event.scancode == KEY_RIGHT:
				$Screen/right.visible = true
				$Screen/right/Timer.start()
				cur = (cur+1) % 4
				if (cur == 4):
					cur = 0

func _on_Timer_timeout():
	$Screen/up.visible = false

func _on_Timer_timeout_down():
	$Screen/down.visible = false

func _on_Timer_timeout_left():
	$Screen/left.visible = false

func _on_Timer_timeout_right():
	$Screen/right.visible = false

func _start_show():
	show()
	get_node("Guide")._start_show()
	
func _start_show2():
	self.z_index = 5
	showing = true
	counter = 0
	set_physics_process(true)
	
func _stop_show():
	showing = false
	hide()
	get_node("../blur").hide()

func _unlock():
	_stop_show()
	get_node(player_path).canMove = true
	var items = get_node(player_path).get_node("Camera2D/Inventory").item_ids
	var idx = items.find("407-1")
	items.remove(idx)
	items.insert(idx, "407-2")
	get_node(player_path).get_node("Camera2D/Inventory").item_ids = items
