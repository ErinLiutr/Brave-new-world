extends Sprite

var printing = false
var donePrinting = false

var pressed = false

var timer = 0
var textToPrint = []

var currentChar = 0
var currentText = 0

const SPEED = 0.04


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	
func _unhandled_key_input(event):
	if event.is_action_pressed("ui_interact"):
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false

func _physics_process(delta):
	if printing:
		if !donePrinting:
			timer += delta
			if timer > SPEED:
				timer = 0
				get_node("RichTextLabel").set_bbcode(get_node("RichTextLabel").get_bbcode() + textToPrint[currentText][currentChar])
				currentChar += 1
				
			if currentChar >= textToPrint[currentText].length():
				currentChar = 0
				timer = 0
				donePrinting = true
				currentText += 1
		elif pressed:
			if currentText < textToPrint.size():
				donePrinting = false
				get_node("RichTextLabel").set_bbcode("")
			
		elif currentText >= textToPrint.size():
			if Input.is_action_just_pressed("ui_no"):
				currentText = 0
				textToPrint = []
				printing = false
				hide()
				get_node("/root/Room/YSort/Player").canMove = true
			elif Input.is_action_just_pressed("ui_yes"):
				currentText = 0
				textToPrint = []
				printing = false
				hide()
				get_node("../World").show()
				get_node("../World")._start_show()
			
	pressed = false			


func _print_dialogue():
	textToPrint = ["I really missed hanging out with him.", "Enter combat? \n [Y] Yes      [N] No"]
	printing = true
