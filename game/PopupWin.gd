extends Control

var invent_node
var choice_item = preload("res://Choice.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	invent_node = get_node("/root/Room/YSort/Player/Camera2D/Inventory")

func _on_TextureButton_pressed():
	# return to main scene
	get_node("PopupPanel").hide()
	get_parent().get_parent().get_node("Puzzle")._stop_show()
	get_node("/root/Room/cabinet3/cabinet2/Interact").id = "208"
	var node = get_node("/root/Room/YSort/Player/Camera2D/Description")
	node.get_node("Choices/Description").text = invent_node.get_info("208", "description")
	node.get_node("Choices/Name").text = invent_node.get_info("208", "name")
	var idx = 0
	for choice in invent_node.get_info("208", "options"):
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
	node.get_node(invent_node.get_info("208", "picture")).show()
	node.show()
	node._start_show()
	node.get_node("Choices").counter = 0
	node.get_node("Choices").current_selection = 0
	node.get_node("Choices").showing = true
	node.get_node("Choices").item_id = "208"
	node.get_node("Choices").show()
	
