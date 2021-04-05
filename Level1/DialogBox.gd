extends Sprite

var choice_item = preload("res://Choice.tscn")
var combat_scene = preload("res://Combat.tscn")

export var player_path = ""
export var default_dialog = ""

var printing = false
var donePrinting = false
var combat = false
var animate = false
var refuse = false
var accept = false
var guide1 = false
var guide2 = false

var showing = false

var pressed = false

var next_dialog = "-1"

var timer = 0
var textToPrint = []
var counter = 0

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
		counter += 1
		if !donePrinting:
			if pressed and counter > 10:
				get_node("RichTextLabel").set_bbcode(textToPrint[currentText])
				currentChar = 0
				timer = 0
				donePrinting = true
				currentText += 1
				counter = 0
			else:
				timer += delta
				if timer > SPEED:
					timer = 0
					get_node("RichTextLabel").set_bbcode(get_node("RichTextLabel").get_bbcode() + textToPrint[currentText][currentChar])
					currentChar += 1
					
				if currentChar >= textToPrint[currentText].length():
					counter = 0
					currentChar = 0
					timer = 0
					donePrinting = true
					currentText += 1
		elif currentText >= textToPrint.size():
			if pressed:
				currentText = 0
				get_node("RichTextLabel").set_bbcode("")
				textToPrint = []
				printing = false
				counter = 0
				if combat:
					var TheRoot = get_node("/root")
					var this_scene = TheRoot.get_node("Room")
					var next_scene = combat_scene.instance()
					next_scene.previous_scene = this_scene
					TheRoot.remove_child(this_scene)
					TheRoot.add_child(next_scene)
					hide()
				elif animate:
					animate = false
					hide()
					get_node(player_path).turn_right()
				elif refuse:
					get_node("/root/Prologue/YSort/Pearl/Interact").id = "44"
					_start("00")
				elif accept:
					get_node("/root/Prologue")._progress()
					hide()
				elif guide1:
					get_node("../Guide1")._start_show()
					hide()
				elif guide2:
					get_node("../Guide2")._start_show()
					get_node("../Inventory").show_guide = true
					hide()
				elif next_dialog == "-1":
					_start("00")
				else:
					_start(next_dialog)
					#get_node("/root/Room/YSort/Player").canMove = true
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
	counter = 0
	next_dialog = "-1"
	animate = false
	refuse = false
	accept = false
	guide1 = false
	guide2 = false
	for node in ["NPC", "MC", "Pearl"]:
			get_node(node).hide()
	if id == "00":
		hide()
		get_node(player_path).canMove = true
	elif json[id]["type"] == "choice":
		get_node(json[id]["role"]).show()
		_show_choices(json[id]["title"], json[id]["choices"], json[id]["close"])
	elif json[id]["type"] == "dialog":
		get_node(json[id]["role"]).show()
		combat = false
		if json[id]["next"] == "":
			next_dialog = "-1"
		elif json[id]["next"] == "animation":
			animate = true
		elif json[id]["next"] == "refuse":
			refuse = true
		elif json[id]["next"] == "accept":
			accept = true
		elif json[id]["next"] == "guide1":
			guide1 = true
		elif json[id]["next"] == "guide2":
			guide2 = true
		else:
			next_dialog = json[id]["next"]
		_print_dialogue(json[id]["text"])
	elif json[id]["type"] == "description":
		get_node(json[id]["role"]).show()
		_show_description(json[id]["text"])
	elif json[id]["type"] == "game":
		get_node(json[id]["role"]).show()
		combat = true
		_print_dialogue(json[id]["text"])
	if id == "19":
		get_node("/root/Room/YSort/Player/Camera2D/Inventory").item_ids.erase("103")
		get_node("/root/Room/YSort/Player/Camera2D/Inventory").item_ids.append("218")
		get_node("/root/Room/YSort/Player").equipment = ""
		get_node("/root/Room/YSort/Player/Camera2D/ToolBar/Equipment/Check").hide()

func _print_dialogue(text):
	get_node("RichTextLabel").show()
	textToPrint = text
	donePrinting = false
	printing = true
	
func _show_choices(title, choices, close):
	get_node("Choices").choice_results = []
	get_node("Choices").close = close
	get_node("Choices/Title").text = title
	var idx = 0
	
	for choice in choices:
		if choice["text"] == "CONFRONT":
			var items = get_node("/root/Room/YSort/Player/Camera2D/Inventory").item_ids
			var counter = 0
			for id in ["206", "213", "208", "207"]:
				if items.has(id):
					counter += 1
			if counter != 4:
				choice["go_to"] = "09"
				json["09"]["text"] = str(counter) + "/4 key items collected to unlock."
			else:
				choice["go_to"] = "07"
		elif choice["text"] == "HAND OUT BANK CHECK":
			if get_node("/root/Room/YSort/Player").equipment != "103":
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
	"""
	var new_choice1 = choice_item.instance()
	new_choice1.name = "choice" + str(idx)
	new_choice1.get_node("selector").text = ""
	new_choice1.get_node("choice").text = "COMBAT WITHOUT COLLECTING"
	get_node("Choices").choice_results.append("07")
	get_node("Choices/GridContainer").add_child(new_choice1)
	idx += 1
	var new_choice = choice_item.instance()
	new_choice.name = "choice" + str(idx)
	new_choice.get_node("selector").text = ""
	new_choice.get_node("choice").text = "CLOSE"
	get_node("Choices").choice_results.append("00")
	get_node("Choices/GridContainer").add_child(new_choice)
	"""
	get_node("Choices").counter = 0
	get_node("Choices").current_selection = 0
	get_node("Choices").showing = true
	get_node("Choices").show()
	
	
func _show_description(text):
	get_node("Description").text = text
	get_node("Description").show()
	get_node("Description")._start_show()

	
