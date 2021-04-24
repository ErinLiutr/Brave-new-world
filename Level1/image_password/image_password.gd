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
	get_node("pic1").texture = load(images[0])
	get_node("pic2").texture = load(images[0])
	get_node("pic3").texture = load(images[0])
	get_node("pic4").texture = load(images[0])
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
			print(stats)
			if (stats == answer):
				print("Correct !")
				win = true
				self.z_index = 0
				$win/PopupMenu.rect_global_position = Vector2(get_parent().global_position.x - 48, get_parent().global_position.y - 44)
				$win.set_process_unhandled_key_input(true)
				$win/PopupMenu.popup()
				set_physics_process(false)
			else:
				print("Wrong!")
				lose = true
				self.z_index = 0
				$lose/PopupMenu.rect_global_position = Vector2(get_parent().global_position.x - 48, get_parent().global_position.y - 44)
				$lose.set_process_unhandled_key_input(true)
				$lose/PopupMenu.popup()
				set_physics_process(false)
		if 0 == cur:
			$select1.visible = true
	#		$"rec1".color = highlight
		else:
			$select1.visible = false
	#		$"rec1".color = normal
		if 1 == cur:
			$select2.visible = true
	#		$"rec2".color = highlight
		else:
			$select2.visible = false
	#		$"rec2".color = normal
		if 2 == cur:
			$select3.visible = true
	#		$"rec3".color = highlight
		else:
			$select3.visible = false
	#		$"rec3".color = normal
		if 3 == cur:
			$select4.visible = true
	#		$"rec4".color = highlight
		else:
			$select4.visible = false
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
				$up.visible = true
				$up/Timer.start()
				var new_idx = (stats[cur]-1)
				if (new_idx < 0):
					new_idx = 3
				if (new_idx > 3):
					new_idx = 0
				print(new_idx)
				stats[cur] = new_idx
				get_node("pic%d"%(cur+1)).texture = load(images[new_idx-1])

		if event is InputEventKey:
			if event.pressed and event.scancode == KEY_DOWN:
				$down.visible = true
				$down/Timer.start()
				var new_idx = (stats[cur]+1) % 4
				if (new_idx < 0):
					new_idx = 3
				if (new_idx > 3):
					new_idx = 0
				stats[cur] = new_idx
				get_node("pic%d"%(cur+1)).texture = load(images[new_idx-1])

		if event is InputEventKey:
			if event.pressed and event.scancode == KEY_LEFT:
				$left.visible = true
				$left/Timer.start()
				cur = (cur-1) % 4
				if (cur == -1):
					cur = 3
		if event is InputEventKey:
			if event.pressed and event.scancode == KEY_RIGHT:
				$right.visible = true
				$right/Timer.start()
				cur = (cur+1) % 4
				if (cur == 4):
					cur = 0

func _on_Timer_timeout():
	$up.visible = false

func _on_Timer_timeout_down():
	$down.visible = false

func _on_Timer_timeout_left():
	$left.visible = false

func _on_Timer_timeout_right():
	$right.visible = false

func _start_show():
	counter = 0
	set_physics_process(true)
	show()
	self.z_index = 5
	showing = true
	
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
