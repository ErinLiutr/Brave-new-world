extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var invent_node
var choice_item = preload("res://Choice.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	invent_node = get_node("/root/Room/YSort/Player/Camera2D/Inventory")


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
		if str(id) == "215":
			get_node("/root/Room/YSort/table/bottle/Interact").id = "216-1"
		if str(id) == "207":
			get_node("/root/Room/YSort/cabinet1/Interact").id = "217-3"
	
	elif destination == "equip":
		get_node("/root/Room/YSort/Player").equipment = str(id)

		var equip_node = get_node("/root/Room/YSort/Player/Camera2D/Equipment/")
		for child in equip_node.get_children():
			if child.name != "selected":
				child.hide()
		var picture = invent_node.get_info(id, "picture")
		get_node("/root/Room/YSort/Player/Camera2D/Equipment/" + picture).show()
	elif destination == "unequip":
		get_node("/root/Room/YSort/Player").equipment = "0"

		var equip_node = get_node("/root/Room/YSort/Player/Camera2D/Equipment/")
		var picture = invent_node.get_info(id, "picture")
		equip_node.get_node(picture).hide()
	elif destination == "combine":
		invent_node.combine(id)
	elif destination == "password":
		get_node("/root/Room/YSort/Player/Camera2D/blur").show()
		get_node("/root/Room/YSort/Player/Camera2D/Password")._start_show()
		get_node("/root/Room/YSort/Player").canMove = false
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
			new_choice.get_node("choice").text = choice

			node.get_node("Choices").choice_results.append(choice)
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
			new_choice.get_node("choice").text = choice

			node.get_node("Choices").choice_results.append(choice)
			node.get_node("Choices/GridContainer").add_child(new_choice)
		node.get_node(invent_node.get_info("207", "picture")).show()
		node.show()
		node._start_show()
		node.get_node("Choices").counter = 0
		node.get_node("Choices").current_selection = 0
		node.get_node("Choices").showing = true
		node.get_node("Choices").item_id = "207"
		node.get_node("Choices").show()
	elif destination == "close":
		get_parent().get_parent()._stop_show()
