extends Node2D

# set up the reset button
export (NodePath) var button_path
onready var button = get_node(button_path)

var img_node = load("poster.tscn")
var img = []
var move = Vector2.ZERO
var speed = 3
var map = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [9, 10, 11]]
var conversion_map = [10, 8, 4, 0, 7, 1, 9, 3, 6, 2, 5, 11]

var showing = false

var pressed = false
var counter = 0

func _ready():
	button.connect("pressed", self, "reset")
	for n in range(12):
		img.append(img_node.instance())
		img[n].set_frame(conversion_map[n])
		add_child(img[n])
		for y in range(4):
			if map[y].find(n) != -1:
				img[n].position = Vector2(map[y].find(n)*30, y*30)
	img[11].visible = false
	set_physics_process(true)
	set_process_unhandled_key_input(true)

func move(dir):
	for y in range(4):
			if map[y].find(11) != -1:
				var pos = Vector2(y, map[y].find(11)) + dir
				pos.x = min(max(pos.x, 0), 3)
				pos.y = min(max(pos.y, 0), 2)
				img[map[y][map[y].find(11)]].position = Vector2(pos.y*30, pos.x*30)
				if img[map[pos.x][pos.y]].position != Vector2(map[y].find(11)*30, y*30):
					move = dir
					img[map[pos.x][pos.y]].position = img[map[pos.x][pos.y]].position - Vector2(dir.y*speed, dir.x*speed)
				else:
					map[y][map[y].find(11)] = map[pos.x][pos.y]
					map[pos.x][pos.y] = 11
					move = Vector2.ZERO
				break
func step(key, dir):
	if Input.is_key_pressed(key) and move == Vector2.ZERO or move == dir:
		print(dir)
		move(dir)

func check_ready():
	pass

# reset the puzzle game
func reset():
	# Restart game
	var root = get_tree().get_root()
	var pos = get_node(".").position
	root.get_node("Room/cabinet2/StaticBody2D").remove_child(get_node("."))
	
	var new_scene = load("res://sliding_poster.tscn")
	var new = new_scene.instance()
	new.position = pos
	new.name = "Interact"
	new._start_show()
	root.get_node("Room/cabinet2/StaticBody2D").add_child(new)

	#get_tree().paused = false

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_interact"):
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false
	
func _physics_process(_delta):
	
	if showing:
		step(KEY_DOWN, Vector2(-1, 0))
		step(KEY_RIGHT, Vector2(0, -1))
		step(KEY_LEFT, Vector2(0, 1))
		step(KEY_UP, Vector2(1, 0))
		counter += 1
		if pressed and counter > 10:
			counter = 0
			hide()
			showing = false
			get_node("/root/Room/cabinet2/StaticBody2D/blur").hide()
			get_node("/root/Room/YSort/Player").canMove = true
	pressed = false
	
func _start_show():
	showing = true




