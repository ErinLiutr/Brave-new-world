extends Sprite

var showing = false

var pressed = false
var counter = 0

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)

func _start_show():
	showing = true

func _stop_show():
	counter = 0
	get_node("Choices/Description").text = ""
	hide()
	showing = false
	print("4")
	get_node("/root/Room/YSort/Player").canMove = true
