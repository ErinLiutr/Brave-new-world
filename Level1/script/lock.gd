extends Node2D
var numbers = []
var ans = [0, 6, 0, 6]
var lost = false

onready var popup_win = get_node("/root/Room/YSort/Player/Camera2D/blur/PopupWin/PopupMenu")
onready var popup_lose = get_node("/root/Room/YSort/Player/Camera2D/blur/PopupLose/PopupMenu")

var showing = false

var counter = 0

func _physics_process(delta):
	if showing:
		if (len(numbers) != 4 or lost):
			$"open".disabled = true
		else:
			$"open".disabled = false
		for i in range(4):
			if i == 0:
				if (len(numbers) >= 1):
					$num1.texture = load("res://art/numbers/Layer_%d.png"%numbers[i])
			if i == 1:
				if (len(numbers) >= 2):
					$num2.texture = load("res://art/numbers/Layer_%d.png"%numbers[i])
			if i == 2:
				if (len(numbers) >= 3):
					$num3.texture = load("res://art/numbers/Layer_%d.png"%numbers[i])
			if i == 3:
				if (len(numbers) >= 4):
					$num4.texture = load("res://art/numbers/Layer_%d.png"%numbers[i])
		for i in range(4):
			if (len(numbers) <= i):
				if i == 0 :
					$num1.texture = null
				if i == 1 :
					$num2.texture = null
				if i == 2 :
					$num3.texture = null
				if i == 3 :
					$num4.texture = null
	
func _input(event):
	if event is InputEventKey and showing:
		if event.pressed and (event.scancode >= 48 and event.scancode <= 57):
			var number = event.scancode - 48
			if len(numbers) < 4:
				numbers.append(number)
		if event.pressed and event.scancode == 16777220:
			if len(numbers) != 0:
				numbers.pop_back()
	if event is InputEventKey and event.scancode == KEY_Q:
		numbers = []
		_stop_show()
	if event is InputEventKey and event.scancode == KEY_O:
		_open()
		
func check_correctness():
	if len(numbers) != 4:
		return false
	for i in range(4):
		if numbers[i] != ans[i]:
			return false
			
	return true

func _open():
	if showing:
		if (check_correctness()):
			popup_win.rect_global_position = Vector2(get_parent().global_position.x - 48, get_parent().global_position.y - 44)
			self.z_index = 0
			popup_win.is_hidden = false
			popup_win.show()
			showing = false
		else:
			lost = true
			popup_lose.rect_global_position = Vector2(get_parent().global_position.x - 48, get_parent().global_position.y - 44)
			self.z_index = 0
			popup_lose.show()
			showing = false


func _reset():
	var root = get_tree().get_root()
	var pos = get_node(".").position
	root.get_node("Room/YSort/Player/Camera2D").remove_child(get_node("."))
	
	var new_scene = load("res://Scene/lock.tscn")
	var new = new_scene.instance()
	new.position = pos
	new.scale = Vector2(0.3, 0.3)
	new.name = "Password"
	new._start_show()
	root.get_node("Room/YSort/Player/Camera2D").add_child(new)

		
func _start_show():
	show()
	self.z_index = 5
	showing = true
	
func _stop_show():
	counter = 0
	hide()
	showing = false
	get_node("../blur").hide()
	get_node("/root/Room/YSort/Player").canMove = true
