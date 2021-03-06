extends Sprite

var choice_item = preload("res://Choice.tscn")
var combat_scene = preload("res://Combat.tscn")
var combat2_scene = preload("res://Combat2.tscn")
var combat3_scene = preload("res://Combat3.tscn")


export var player_path = ""
export var default_dialog = ""

var printing = false
var donePrinting = false
var combat = false
var combat2 = false
var combat3 = false
var animate = false
var refuse = false
var accept = false
var guide1 = false
var guide2 = false
var prologue = false
var title = false
var door = false
var door1 = false
var phone = false
var recording = false
var ending = false

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
	print("ready")
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
					MusicController.play_battle()
					hide()
				elif combat2:
					var TheRoot = get_node("/root")
					var this_scene = TheRoot.get_node("Room2")
					var next_scene = combat2_scene.instance()
					next_scene.previous_scene = this_scene
					#next_scene.next_scene = this_scene.base_scene.instance()
					TheRoot.remove_child(this_scene)
					TheRoot.add_child(next_scene)
					MusicController.play_battle2()
					hide()
				elif combat3:
					var TheRoot = get_node("/root")
					var this_scene = TheRoot.get_node("Room2")
					var next_scene = combat3_scene.instance()
					next_scene.previous_scene = this_scene
					#next_scene.next_scene = this_scene.base_scene.instance()
					TheRoot.remove_child(this_scene)
					TheRoot.add_child(next_scene)
					MusicController.play_battle2()
					hide()
				elif animate:
					animate = false
					hide()
					get_node(player_path).turn_right()
				elif refuse:
					get_node("/root/Prologue/YSort/Pearl/Interact").id = "44"
					_start("00")
				elif accept:
					get_parent().get_node("Chapter1")._play_fadein()
					hide()
				elif guide1:
					get_node("../Guide1")._start_show()
					_start("00")
				elif guide2:
					get_node("../Guide2")._start_show()
					_start("00")
				elif prologue:
					get_parent().get_node("Ending")._play_fadein()
					hide()
				elif title:
					if get_parent().get_parent().get_parent().get_parent().name == "Epilogue":
						get_node("/root/Epilogue/Credit")._play()
					else:
						get_node("/root/Prologue/YSort/Player/Camera2D/Credit")._play()
					hide()
				elif ending:
					get_node("/root/Basement/YSort/Player/Camera2D/Ending")._play_fadein()
				elif phone:
					hide()
					var invent_node = get_node(player_path + "/Camera2D/Inventory")
					var node = get_node(player_path + "/Camera2D/Description")
					node.get_node("Choices/Description").text = invent_node.get_info("407-1", "description")
					node.get_node("Choices/Name").text = invent_node.get_info("407-1", "name")
					var idx = 0
					var new_choice1 = choice_item.instance()
					new_choice1.name = "choice" + str(idx)
					if idx == 0:
						new_choice1.get_node("selector").text = ">"
					else:
						new_choice1.get_node("selector").text = ""
					new_choice1.get_node("choice").text = "PICK"
					node.get_node("Choices").choice_results.append("pick")
					node.get_node("Choices/GridContainer").add_child(new_choice1)
					idx += 1
					var new_choice = choice_item.instance()
					new_choice.name = "choice" + str(idx)
					if idx == 0:
						new_choice.get_node("selector").text = ">"
					else:
						new_choice.get_node("selector").text = ""
					new_choice.get_node("choice").text = "CLOSE"
					node.get_node("Choices").choice_results.append("close")
					node.get_node("Choices/GridContainer").add_child(new_choice)
					node.get_node(invent_node.get_info("407-1", "picture")).show()
					node.show()
					node._start_show()
					node.get_node("Choices").counter = 0
					node.get_node("Choices").current_selection = 0
					node.get_node("Choices").showing = true
					node.get_node("Choices").item_id = "407-1"
					node.get_node("Choices").show()
				elif recording:
					var invent_node = get_node(player_path + "/Camera2D/Inventory")
					if invent_node.item_ids.has("411"):
						_start("00")
					else:
						hide()
						var node = get_node(player_path + "/Camera2D/Description")
						node.get_node("Choices/Description").text = invent_node.get_info("411", "description")
						node.get_node("Choices/Name").text = invent_node.get_info("411", "name")
						var idx = 0
						var new_choice1 = choice_item.instance()
						new_choice1.name = "choice" + str(idx)
						if idx == 0:
							new_choice1.get_node("selector").text = ">"
						else:
							new_choice1.get_node("selector").text = ""
						new_choice1.get_node("choice").text = "PICK"
						node.get_node("Choices").choice_results.append("pick")
						node.get_node("Choices/GridContainer").add_child(new_choice1)
						idx += 1
						var new_choice = choice_item.instance()
						new_choice.name = "choice" + str(idx)
						if idx == 0:
							new_choice.get_node("selector").text = ">"
						else:
							new_choice.get_node("selector").text = ""
						new_choice.get_node("choice").text = "CLOSE"
						node.get_node("Choices").choice_results.append("close")
						node.get_node("Choices/GridContainer").add_child(new_choice)
						node.get_node(invent_node.get_info("411", "picture")).show()
						node.show()
						node._start_show()
						node.get_node("Choices").counter = 0
						node.get_node("Choices").current_selection = 0
						node.get_node("Choices").showing = true
						node.get_node("Choices").item_id = "411"
						node.get_node("Choices").show()
				elif door:
					if get_node("/root/Corridor/door/Sprite").get_frame() != 0:
						_start("00")
					else:
						get_node("/root/Corridor/door")._open()
						hide()
				elif door1:
					get_node("/root/Room/door")._open()
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
	if id == "-1":
		return
	counter = 0
	next_dialog = "-1"
	animate = false
	refuse = false
	accept = false
	guide1 = false
	guide2 = false
	prologue = false
	title = false
	door = false
	door1 = false
	combat2 = false
	combat3 = false
	phone = false
	recording = false
	ending = false
	for node in ["NPC", "MC", "Pearl", "MC1", "Lydia", "CJ", "Police", "Issac"]:
			get_node(node).hide()
	if id == "129":
		var ids = get_node("/root/Room2/YSort/Player/Camera2D/Inventory").item_ids
		if !((ids.has("402") and ids.has("410") and ids.has("414")) or (ids.has("402") and ids.has("410") and ids.has("401") and ids.has("404") and ids.has("411"))):
			id = "17"
	if id == "00":
		hide()
		if player_path != "":
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
		elif json[id]["next"] == "prologue":
			prologue = true
		elif json[id]["next"] == "recording":
			recording = true
		elif json[id]["next"] == "title":
			title = true
		elif json[id]["next"] == "phone":
			phone = true
		elif json[id]["next"] == "door":
			door = true
		elif json[id]["next"] == "door1":
			door1 = true
		elif json[id]["next"] == "combat2":
			combat2 = true
		elif json[id]["next"] == "combat3":
			combat3 = true
		elif json[id]["next"] == "ending":
			ending = true
		else:
			next_dialog = json[id]["next"]
		_print_dialogue(json[id]["text"])
	elif json[id]["type"] == "description":
		get_node(json[id]["role"]).show()
		if json[id]["role"] == "Lydia":
			default_dialog = "106"
		elif json[id]["role"] == "CJ":
			default_dialog = "107"
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
	if id == "96":
		#get_node("/root/Corridor/YSort/Lydia/Interact").id = "00"
		get_node("/root/Corridor/YSort/Lydia/Interact").done = true
	if id == "101":
		#get_node("/root/Corridor/YSort/CJ/Interact").id = "00"
		get_node("/root/Corridor/YSort/CJ/Interact").done = true
	if id == "114":
		get_node("/root/Room2/YSort/Lydia").pw = true
	if id == "121":
		get_node("/root/Room2/YSort/Police/Interact").id = "108"

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
			var items = get_node(player_path + "/Camera2D/Inventory").item_ids
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
		elif choice["text"] == "PICK ISSAC'S PHONE":
			var items = get_node(player_path + "/Camera2D/Inventory").item_ids
			if !items.has("402") or !items.has("410") or items.has("407-1") or items.has("407-2"):
				continue
		elif choice["text"] == "ASK ABOUT RECORDING":
			var items = get_node(player_path + "/Camera2D/Inventory").item_ids
			if !items.has("402") or !items.has("410") or !items.has("401"):
				continue
		elif choice["text"] == "ASK ABOUT ISSAC'S MEMO":
			var items = get_node(player_path + "/Camera2D/Inventory").item_ids
			if !items.has("407-2"):
				continue
		elif choice["text"] == "ASK ABOUT LAPTOP PASSWORD":
			var items = get_node(player_path + "/Camera2D/Inventory").item_ids
			if !get_node("/root/Room2/YSort/Lydia").pw:
				continue
		elif choice["text"] == "A is guilty":
			var ids = get_node(player_path + "/Camera2D/Inventory").item_ids
			if !(ids.has("402") and ids.has("410") and ids.has("414")):
				continue
		elif choice["text"] == "Lydia is guilty":
			var ids = get_node(player_path + "/Camera2D/Inventory").item_ids
			if !(ids.has("402") and ids.has("410") and ids.has("404") and ids.has("401") and ids.has("411")):
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

	
