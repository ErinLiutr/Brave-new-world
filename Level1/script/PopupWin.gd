extends Control

var pressed = false

var invent_node
var choice_item = preload("res://Choice.tscn")

func _ready():
	invent_node = get_node("/root/Room/YSort/Player/Camera2D/Inventory")
	set_physics_process(true)
	set_process_unhandled_key_input(true)

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_interact"):
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false

func _physics_process(delta):
	if get_parent().get_parent().get_node("Password").win:
		if pressed:
			get_node("PopupMenu").hide()
			get_node("/root/Room/YSort/Player/Camera2D/Password")._stop_show()
			get_node("/root/Room/YSort/table/bottle/Interact").id = "216-1"
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
	pressed = false


