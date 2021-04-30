extends Control


var pressed = false
var choice_item = preload("res://Choice.tscn")
var invent_node

func _ready():
	invent_node = get_node(get_parent().get_parent().player_path + "/Camera2D/Inventory")
	set_physics_process(true)
	set_process_unhandled_key_input(false)

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_interact"):
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false

func _physics_process(delta):
	if get_parent().get_parent().win:
		if pressed:
			get_node("PopupMenu").hide()
			get_parent().get_parent()._unlock()
			get_node(get_parent().get_parent().player_path).canMove = false
			var node = get_node(get_parent().get_parent().player_path + "/Camera2D/Description")
			node.get_node("Choices/Description").text = invent_node.get_info("407-2", "description")
			node.get_node("Choices/Name").text = invent_node.get_info("407-2", "name")
			var idx = 0
			for choice in invent_node.get_info("407-2", "options"):
				var new_choice = choice_item.instance()
				new_choice.name = "choice" + str(idx)
				if idx == 0:
					new_choice.get_node("selector").text = ">"
				else:
					new_choice.get_node("selector").text = ""
				idx += 1
				if choice == "memo":
					new_choice.get_node("choice").text = "VIEW MEMO"
					node.get_node("Choices").choice_results.append("memo")
					node.get_node("Choices/GridContainer").add_child(new_choice)
				elif choice == "recording":
					new_choice.get_node("choice").text = "PLAY RECORDING"
					node.get_node("Choices").choice_results.append("recording")
					node.get_node("Choices/GridContainer").add_child(new_choice)
				else:
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
			node.get_node(invent_node.get_info("407-2", "picture")).show()
			node.show()
			node._start_show()
			node.get_node("Choices").counter = 0
			node.get_node("Choices").current_selection = 0
			node.get_node("Choices").showing = true
			node.get_node("Choices").item_id = "407-2"
			node.get_node("Choices").show()
			set_process_unhandled_key_input(false)
	pressed = false
