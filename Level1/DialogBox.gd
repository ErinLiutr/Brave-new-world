extends Sprite

var choice_item = preload("res://Choice.tscn")
var combat_scene = preload("res://Scene/world.tscn")

var printing = false
var donePrinting = false
var combat = false

var showing = false

var pressed = false

var timer = 0
var textToPrint = []

var currentChar = 0
var currentText = 0

const SPEED = 0.04

var script_url = "res://scratch.json"
var json

# Called when the node enters the scene tree for the first time.
func _ready():
	json = load_data(script_url)
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
		elif currentText >= textToPrint.size():
			if Input.is_action_just_pressed("ui_no"):
				currentText = 0
				textToPrint = []
				printing = false
				hide()
				showing = false
				get_node("/root/Room/YSort/Player").canMove = true
			elif pressed:
				currentText = 0
				get_node("RichTextLabel").set_bbcode("")
				textToPrint = []
				printing = false
				if combat:
					var TheRoot = get_node("/root")
					var this_scene = TheRoot.get_node("Room")
					var next_scene = combat_scene.instance()
					next_scene.previous_scene = this_scene
					TheRoot.remove_child(this_scene)
					TheRoot.add_child(next_scene)
				else:
					_start("01")
		elif pressed:
			if currentText < textToPrint.size():
				donePrinting = false
				get_node("RichTextLabel").set_bbcode("")
			
			
	pressed = false			

func load_data(url):
	var file = File.new()
	if url == null: return null
	if !file.file_exists(url): return null
	file.open(url, File.READ)
	var data = {}
	data = parse_json(file.get_as_text())
	file.close()
	return data
	
func _start(id):
	if id == "00":
		hide()
		showing = false
		get_node("/root/Room/YSort/Player").canMove = true
	elif json[id]["type"] == "choice":
		_show_choices(json[id]["title"], json[id]["choices"])
	elif json[id]["type"] == "dialog":
		combat = false
		_print_dialogue(json[id]["text"])
	elif json[id]["type"] == "description":
		_show_description()
	elif json[id]["type"] == "game":
		combat = true
		_print_dialogue(json[id]["text"])
	

func _print_dialogue(text):
	get_node("RichTextLabel").show()
	textToPrint = text
	printing = true
	
func _show_choices(title, choices):
	get_node("Choices").choice_results = []

	get_node("Choices/Title").text = title
	var idx = 0
	
	for choice in choices:
		if choice["text"] == "CONFRONT":
			var items = get_node("/root/Room/YSort/Player/Camera2D/Inventory").item_ids
			if !(items.has("203") and items.has("213") and items.has("208") and items.has("207")):
				continue
		var new_choice = choice_item.instance()
		new_choice.name = "choice" + str(idx)
		if idx == 0:
			new_choice.get_node("selector").text = ">"
		else:
			new_choice.get_node("selector").text = ""
		idx += 1
		new_choice.get_node("choice").text = choice["text"]
		get_node("Choices").choice_results.append(choice["go_to"])
		get_node("Choices/GridContainer").add_child(new_choice)
	var new_choice = choice_item.instance()
	new_choice.name = "choice" + str(idx)
	new_choice.get_node("selector").text = ""
	new_choice.get_node("choice").text = "CLOSE"
	get_node("Choices").choice_results.append("00")
	get_node("Choices/GridContainer").add_child(new_choice)
	get_node("Choices").counter = 0
	get_node("Choices").current_selection = 0
	get_node("Choices").showing = true
	get_node("Choices").show()
	
func _show_description():
	get_node("Description").show()
	get_node("Description")._start_show()

	
