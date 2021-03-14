extends Node2D


var previous_scene

# Called when the node enters the scene tree for the first time.
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
	counter += 1
	if pressed and counter > 10:
		counter = 0
		var TheRoot = get_node("/root")
		var this_scene = get_node("/root/World")
		TheRoot.remove_child(this_scene)
		previous_scene.get_node("YSort/Player/Camera2D/DialogBox").show()
		previous_scene.get_node("YSort/Player/Camera2D/DialogBox")._start("08")
		TheRoot.add_child(previous_scene)
		#get_node("/root/Room/YSort/Player").canMove = true
	pressed = false
