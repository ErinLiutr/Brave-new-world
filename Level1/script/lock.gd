extends Node2D
var numbers = []
var ans = [0, 6, 0, 6]
var lost = false

onready var popup_win = get_node("/root/Room/YSort/Player/Camera2D/blur/PopupWin/PopupMenu")
onready var popup_lose = get_node("/root/Room/YSort/Player/Camera2D/blur/PopupLose/PopupMenu")

var showing = false
var win = false
var lose = false

var pressed = false
var cheat = false
var cancel = false

var counter = 0

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)

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
		if (len(numbers)==4):
			$"Open".visible = true
		if cancel:
			numbers = []
			_stop_show()
		if pressed and len(numbers)==4:
			_open()
		# cheat
		if cheat:
			numbers = [0, 6, 0, 6]
	pressed = false
	cheat = false
	cancel = false
				
func _input(event):
	if event is InputEventKey and showing:
		if event.pressed and (event.scancode >= 48 and event.scancode <= 57):
			var number = event.scancode - 48
			if len(numbers) < 4:
				numbers.append(number)
		if event.pressed and event.scancode == 16777220:
			if len(numbers) != 0:
				numbers.pop_back()
		
func _unhandled_key_input(event):
	if event.is_action_pressed("ui_interact"):
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false
	if event.is_action_pressed("ui_cancel"):
		cancel = true
	elif event.is_action_released("ui_cancel"):
		cancel = false
	if event.is_action_pressed("ui_cheat"):
		cheat = true
	elif event.is_action_released("ui_cheat"):
		cheat = false
		
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
			popup_win.show()
			showing = false
			win = true
		else:
			lost = true
			popup_lose.rect_global_position = Vector2(get_parent().global_position.x - 48, get_parent().global_position.y - 44)
			self.z_index = 0
			popup_lose.show()
			showing = false
			lose = true


func _reset():
	win = false
	lose = false
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
	win = false
	lose = false
	self.z_index = 5
	showing = true
	
func _stop_show():
	win = false
	lose = false
	counter = 0
	hide()
	showing = false
	get_node("../blur").hide()

