extends Node2D

# set up the reset button
export (NodePath) var button_path
onready var button = get_node(button_path)

var img_node = load("poster.tscn")
var img = []
var move = Vector2.ZERO
var speed = 6
var map = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [9, 10, 11]]
var conversion_map = [10, 8, 4, 0, 7, 1, 9, 3, 6, 2, 5, 11]

func _ready():
	button.connect("pressed", self, "reset")
	for n in range(12):
		img.append(img_node.instance())
		img[n].set_frame(conversion_map[n])
		add_child(img[n])
		for y in range(4):
			if map[y].find(n) != -1:
				img[n].position = Vector2(map[y].find(n)*120, y*120)
	img[11].visible = false
	set_physics_process(true)

func move(dir):
	for y in range(4):
			if map[y].find(11) != -1:
				var pos = Vector2(y, map[y].find(11)) + dir
				pos.x = min(max(pos.x, 0), 3)
				pos.y = min(max(pos.y, 0), 2)
				img[map[y][map[y].find(11)]].position = Vector2(pos.y*120, pos.x*120)
				if img[map[pos.x][pos.y]].position != Vector2(map[y].find(11)*120, y*120):
					move = dir
					img[map[pos.x][pos.y]].position = img[map[pos.x][pos.y]].position - Vector2(dir.y*speed, dir.x*speed)
				else:
					map[y][map[y].find(11)] = map[pos.x][pos.y]
					map[pos.x][pos.y] = 11
					move = Vector2.ZERO
				break
func step(key, dir):
	if Input.is_key_pressed(key) and move == Vector2.ZERO or move == dir:
		move(dir)

func check_ready():
	pass

# reset the puzzle game
func reset():
	# Restart game
	get_tree().change_scene("res://sliding_poster.tscn")
	get_tree().paused = false

	
func _physics_process(_delta):
	pass
	step(KEY_DOWN, Vector2(-1, 0))
	step(KEY_RIGHT, Vector2(0, -1))
	step(KEY_LEFT, Vector2(0, 1))
	step(KEY_UP, Vector2(1, 0))
	



