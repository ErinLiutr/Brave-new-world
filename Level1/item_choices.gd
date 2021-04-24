extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var invent_node
var player_path
var choice_item = preload("res://Choice.tscn")

# Called when the node enters the scene tree for the first time.
func init():
	player_path = get_parent().get_parent().player_path
	invent_node = get_node(player_path + "/Camera2D/Inventory")
	print("init", invent_node)


func handle_selection(destination, id):
	get_parent().get_parent()._stop_show()
	if destination == "slidingPuzzle":
		get_node("/root/Room/YSort/Player/Camera2D/blur").show()
		get_node("/root/Room/YSort/Player/Camera2D/Puzzle")._start_show()
		get_node("/root/Room/YSort/Player").canMove = false
	elif destination == "pick":
		var path = invent_node.get_info(id, "path")
		if path != "":
			var node = get_node(path)
			if node.has_node("CollisionShape2D"):
				node.get_node("CollisionShape2D").disabled = true
			node.hide()
		invent_node.item_ids.append(str(id))
		if str(id) == "402" or str(id) == "410":
			if invent_node.item_ids.has("402") and invent_node.item_ids.has("410"):
				get_node("/root/2ndfloor/YSort/Player").canMove = false
				get_node("/root/2ndfloor/YSort/Player/Camera2D/DialogBox").show()
				get_node("/root/2ndfloor/YSort/Player/Camera2D/DialogBox")._start("127")
				get_node("/root/2ndfloor").room_inst.get_node("YSort/Police/Interact").id = "108"
		if str(id) == "215":
			get_node("/root/Room/YSort/table/bottle/Interact").id = "216-2"
		elif str(id) == "207":
			get_node("/root/Room/YSort/cabinet1/Interact").id = "217-3"
		elif str(id) == "101":
			get_node("/root/Prologue/YSort/Drain/Interact").id = "105-1"
			get_node("/root/Prologue/YSort/Drain/Sprite").show()
			get_node("/root/Prologue/YSort/Drain/Sprite2").hide()
			get_node("/root/Prologue/YSort/Player").canMove = false
			get_node("/root/Prologue/YSort/Player/Camera2D/DialogBox").show()
			get_node("/root/Prologue/YSort/Player/Camera2D/DialogBox")._start("42")
		if ["207", "213", "208"].has(str(id)):
			get_node("/root/Room/YSort/Player").canMove = false
			get_node("/root/Room/YSort/Player/Camera2D/DialogBox").show()
			if str(id) == "207":
				get_node("/root/Room/YSort/Player/Camera2D/DialogBox")._start("21")
			elif str(id) == "208":
				get_node("/root/Room/YSort/Player/Camera2D/DialogBox")._start("22")
			elif str(id) == "213":
				get_node("/root/Room/YSort/Player/Camera2D/DialogBox")._start("23")
			if invent_node.item_ids.has("206") and invent_node.item_ids.has("207") and invent_node.item_ids.has("208") and invent_node.item_ids.has("213"):
				get_node("/root/Room/YSort/Player/Camera2D/DialogBox").next_dialog = "24"
		if invent_node.item_ids.has("103") and invent_node.item_ids.has("102") and invent_node.item_ids.has("104") and invent_node.item_ids.size() == 3:
			get_node("/root/Prologue/YSort/Player").canMove = false
			get_node("/root/Prologue/YSort/Player/Camera2D/DialogBox").show()
			get_node("/root/Prologue/YSort/Player/Camera2D/DialogBox")._start("40")
			#get_node("/root/Prologue/YSort/Drain/Interact").active = true
			get_node("/root/Prologue/YSort/Drain/Interact").asked = true
	
	elif destination == "equip":
		if get_node(player_path).guide3:
			get_node(player_path + "/Camera2D/Guide3")._stop_show()
		get_node(player_path).equipment = str(id)

		var equip_node = get_node(player_path + "/Camera2D/ToolBar/Equipment")
		for child in equip_node.get_children():
			child.hide()
		equip_node.get_node("equip").show()
		var picture = invent_node.get_info(id, "picture")
		get_node(player_path + "/Camera2D/ToolBar/Equipment/" + picture).show()
	elif destination == "unequip":
		get_node(player_path).equipment = "0"

		var equip_node = get_node(player_path + "/Camera2D/ToolBar/Equipment")
		equip_node.get_node("equip").hide()
		equip_node.get_node("unequip").show()
		var picture = invent_node.get_info(id, "picture")
		equip_node.get_node(picture).hide()
	elif destination == "combine":
		invent_node.combine(id)
	elif destination == "password":
		get_node("/root/Room/YSort/Player/Camera2D/blur").show()
		get_node("/root/Room/YSort/Player/Camera2D/Password")._start_show()
		get_node("/root/Room/YSort/Player").canMove = false
	elif destination == "phonepw":
		get_node(player_path + "/Camera2D/blur").show()
		get_node(player_path + "/Camera2D/Password")._start_show()
		get_parent().get_parent().get_parent()._stop_show()
		get_node(player_path).canMove = false
	elif destination == "memo":
		get_parent().get_parent().get_parent()._stop_show()
		get_node(player_path).canMove = false
		get_node(player_path + "/Camera2D/DialogBox").show()
		get_node(player_path + "/Camera2D/DialogBox")._start("136")
	elif destination == "recording":
		get_parent().get_parent().get_parent()._stop_show()
		get_node(player_path).canMove = false
		get_node(player_path + "/Camera2D/DialogBox").show()
		get_node(player_path + "/Camera2D/DialogBox")._start("137")
	elif destination == "lightup":
		get_node("/root/Basement/YSort/Player/Camera2D/blur").show()
		get_node("/root/Basement/YSort/Player/Camera2D/Lightup")._start_show()
		get_node("/root/Basement/YSort/Player").canMove = false
	elif destination == "key":
		get_node("/root/Room/YSort/Player").canMove = false
		var node = get_node("/root/Room/YSort/Player/Camera2D/Description")
		node.get_node("Choices/Description").text = invent_node.get_info("215", "description")
		node.get_node("Choices/Name").text = invent_node.get_info("215", "name")
		var idx = 0
		for choice in invent_node.get_info("215", "options"):
			var new_choice = choice_item.instance()
			new_choice.name = "choice" + str(idx)
			if idx == 0:
				new_choice.get_node("selector").text = ">"
			else:
				new_choice.get_node("selector").text = ""
			idx += 1
			new_choice.get_node("choice").text = choice.to_upper()

			node.get_node("Choices").choice_results.append(choice)
			node.get_node("Choices/GridContainer").add_child(new_choice)
		var new_choice = choice_item.instance()
		new_choice.name = "choice" + str(idx)
		if idx == 0:
			new_choice.get_node("selector").text = ">"
		else:
			new_choice.get_node("selector").text = ""
		new_choice.get_node("choice").text = "CLOSE"
		node.get_node("Choices").choice_results.append("close")
		node.get_node("Choices/GridContainer").add_child(new_choice)
		node.get_node(invent_node.get_info("215", "picture")).show()
		node.show()
		node._start_show()
		node.get_node("Choices").counter = 0
		node.get_node("Choices").current_selection = 0
		node.get_node("Choices").showing = true
		node.get_node("Choices").item_id = "215"
		node.get_node("Choices").show()
	elif destination == "unlock":
		get_node("/root/Room/YSort/cabinet1/Interact").id = "217-2"
		get_node("/root/Room/YSort/Player").canMove = false
		var node = get_node("/root/Room/YSort/Player/Camera2D/Description")
		node.get_node("Choices/Description").text = invent_node.get_info("217-2", "description")
		node.get_node("Choices/Name").text = invent_node.get_info("217-2", "name")
		var idx = 0
		for choice in invent_node.get_info("217-2", "options"):
			var new_choice = choice_item.instance()
			new_choice.name = "choice" + str(idx)
			if idx == 0:
				new_choice.get_node("selector").text = ">"
			else:
				new_choice.get_node("selector").text = ""
			idx += 1
			new_choice.get_node("choice").text = "VIEW"

			node.get_node("Choices").choice_results.append(choice)
			node.get_node("Choices/GridContainer").add_child(new_choice)
		var new_choice = choice_item.instance()
		new_choice.name = "choice" + str(idx)
		if idx == 0:
			new_choice.get_node("selector").text = ">"
		else:
			new_choice.get_node("selector").text = ""
		new_choice.get_node("choice").text = "CLOSE"
		node.get_node("Choices").choice_results.append("close")
		node.get_node("Choices/GridContainer").add_child(new_choice)
		node.get_node(invent_node.get_info("217-2", "picture")).show()
		node.show()
		node._start_show()
		node.get_node("Choices").counter = 0
		node.get_node("Choices").current_selection = 0
		node.get_node("Choices").showing = true
		node.get_node("Choices").item_id = "217-2"
		node.get_node("Choices").show()
	elif destination == "report":
		get_node("/root/Room/YSort/Player").canMove = false
		var node = get_node("/root/Room/YSort/Player/Camera2D/Description")
		node.get_node("Choices/Description").text = invent_node.get_info("207", "description")
		node.get_node("Choices/Name").text = invent_node.get_info("207", "name")
		var idx = 0
		for choice in invent_node.get_info("207", "options"):
			var new_choice = choice_item.instance()
			new_choice.name = "choice" + str(idx)
			if idx == 0:
				new_choice.get_node("selector").text = ">"
			else:
				new_choice.get_node("selector").text = ""
			idx += 1
			new_choice.get_node("choice").text = choice.to_upper()

			node.get_node("Choices").choice_results.append(choice)
			node.get_node("Choices/GridContainer").add_child(new_choice)
		var new_choice = choice_item.instance()
		new_choice.name = "choice" + str(idx)
		if idx == 0:
			new_choice.get_node("selector").text = ">"
		else:
			new_choice.get_node("selector").text = ""
		new_choice.get_node("choice").text = "CLOSE"
		node.get_node("Choices").choice_results.append("close")
		node.get_node("Choices/GridContainer").add_child(new_choice)
		node.get_node(invent_node.get_info("207", "picture")).show()
		node.show()
		node._start_show()
		node.get_node("Choices").counter = 0
		node.get_node("Choices").current_selection = 0
		node.get_node("Choices").showing = true
		node.get_node("Choices").item_id = "207"
		node.get_node("Choices").show()
	elif destination == "id":
		get_node("/root/Prologue/YSort/Player").canMove = false
		var node = get_node("/root//Prologue/YSort/Player/Camera2D/Description")
		node.get_node("Choices/Description").text = invent_node.get_info("101", "description")
		node.get_node("Choices/Name").text = invent_node.get_info("101", "name")
		var idx = 0
		for choice in invent_node.get_info("101", "options"):
			var new_choice = choice_item.instance()
			new_choice.name = "choice" + str(idx)
			if idx == 0:
				new_choice.get_node("selector").text = ">"
			else:
				new_choice.get_node("selector").text = ""
			idx += 1
			new_choice.get_node("choice").text = choice.to_upper()

			node.get_node("Choices").choice_results.append(choice)
			node.get_node("Choices/GridContainer").add_child(new_choice)
		var new_choice = choice_item.instance()
		new_choice.name = "choice" + str(idx)
		if idx == 0:
			new_choice.get_node("selector").text = ">"
		else:
			new_choice.get_node("selector").text = ""
		new_choice.get_node("choice").text = "CLOSE"
		node.get_node("Choices").choice_results.append("close")
		node.get_node("Choices/GridContainer").add_child(new_choice)
		node.get_node(invent_node.get_info("101", "picture")).show()
		node.show()
		node._start_show()
		node.get_node("Choices").counter = 0
		node.get_node("Choices").current_selection = 0
		node.get_node("Choices").showing = true
		node.get_node("Choices").item_id = "101"
		node.get_node("Choices").show()
	elif destination == "inspection":
		get_node("/root/2ndfloor/YSort/Player").canMove = false
		get_node("/root/2ndfloor/YSort/shelf1/Interact").id = "421-2"
		var node = get_node("/root/2ndfloor/YSort/Player/Camera2D/Description")
		node.get_node("Choices/Description").text = invent_node.get_info("402", "description")
		node.get_node("Choices/Name").text = invent_node.get_info("402", "name")
		var idx = 0
		for choice in invent_node.get_info("402", "options"):
			var new_choice = choice_item.instance()
			new_choice.name = "choice" + str(idx)
			if idx == 0:
				new_choice.get_node("selector").text = ">"
			else:
				new_choice.get_node("selector").text = ""
			idx += 1
			new_choice.get_node("choice").text = choice.to_upper()

			node.get_node("Choices").choice_results.append(choice)
			node.get_node("Choices/GridContainer").add_child(new_choice)
		var new_choice = choice_item.instance()
		new_choice.name = "choice" + str(idx)
		if idx == 0:
			new_choice.get_node("selector").text = ">"
		else:
			new_choice.get_node("selector").text = ""
		new_choice.get_node("choice").text = "CLOSE"
		node.get_node("Choices").choice_results.append("close")
		node.get_node("Choices/GridContainer").add_child(new_choice)
		node.get_node(invent_node.get_info("402", "picture")).show()
		node.show()
		node._start_show()
		node.get_node("Choices").counter = 0
		node.get_node("Choices").current_selection = 0
		node.get_node("Choices").showing = true
		node.get_node("Choices").item_id = "402"
		node.get_node("Choices").show()
	elif destination == "close":
		get_parent().get_parent()._stop_show()
		print(str(id))
		if str(id) == "105" and get_node("/root/Prologue/YSort/Drain/Interact").asked:
			get_node("/root/Prologue/YSort/Player").canMove = false
			get_node("/root/Prologue/YSort/Player/Camera2D/DialogBox").show()
			get_node("/root/Prologue/YSort/Player/Camera2D/DialogBox")._start("41")
			get_node("/root/Prologue/YSort/Drain/Interact").active = true
			get_node("/root/Prologue/YSort/Drain/Interact").asked = false
			
