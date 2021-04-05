extends GridContainer

var item_ids = []

var current_selection = 0

var counter = 0

export var col = 0
var invent_node
var showing = false
var choice_item = preload("res://Choice.tscn")

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	invent_node = get_parent().get_parent()
	
func _physics_process(delta):
	counter += 1
	
func _unhandled_key_input(event):
	if showing:
		if event.is_action_pressed("ui_down") and current_selection + col < item_ids.size():
			get_node(item_ids[current_selection] + "/selected").hide()
			get_node(item_ids[current_selection] + "/unselected").show()
			current_selection += col
			get_node(item_ids[current_selection] + "/unselected").hide()
			get_node(item_ids[current_selection] + "/selected").show()
		elif event.is_action_pressed("ui_up") and current_selection >= col:
			get_node(item_ids[current_selection] + "/selected").hide()
			get_node(item_ids[current_selection] + "/unselected").show()
			current_selection -= col
			get_node(item_ids[current_selection] + "/unselected").hide()
			get_node(item_ids[current_selection] + "/selected").show()
		elif event.is_action_pressed("ui_right") and current_selection + 1 < item_ids.size():
			get_node(item_ids[current_selection] + "/selected").hide()
			get_node(item_ids[current_selection] + "/unselected").show()
			current_selection += 1
			get_node(item_ids[current_selection] + "/unselected").hide()
			get_node(item_ids[current_selection] + "/selected").show()
		elif event.is_action_pressed("ui_left") and current_selection >= 1:
			get_node(item_ids[current_selection] + "/selected").hide()
			get_node(item_ids[current_selection] + "/unselected").show()
			current_selection -= 1
			get_node(item_ids[current_selection] + "/unselected").hide()
			get_node(item_ids[current_selection] + "/selected").show()
		elif event.is_action_pressed("ui_interact") and item_ids.size() > current_selection:
			handle_selection(current_selection)


func handle_selection(_current_selection):
	showing = false
	invent_node.showing = false
	var id = item_ids[_current_selection]
	var desc = invent_node.get_node("Description")
	desc.get_node("Choices/Description").text = invent_node.get_info(id, "description")
	desc.get_node("Choices/Name").text = invent_node.get_info(id, "item_name")
	
	desc.get_node("Choices").choice_results = []
	
	var new_choice = choice_item.instance()
	new_choice.name = "choice0"
	new_choice.get_node("selector").text = ">"
	if id == get_node(get_parent().get_parent().player_path).equipment:
		new_choice.get_node("choice").text = "UNEQUIP"
		desc.get_node("Choices").choice_results.append("unequip")
	else:
		new_choice.get_node("choice").text = "EQUIP"
		desc.get_node("Choices").choice_results.append("equip")
	desc.get_node("Choices/GridContainer").add_child(new_choice)
	
	var new_choice1 = choice_item.instance()
	new_choice1.name = "choice1"
	new_choice1.get_node("selector").text = ""
	new_choice1.get_node("choice").text = "CLOSE"
	desc.get_node("Choices").choice_results.append("close")

	desc.get_node("Choices/GridContainer").add_child(new_choice1)
	desc.get_node("Choices").counter = 0
	desc.get_node("Choices").current_selection = 0
	desc.get_node("Choices").showing = true
	desc.get_node("Choices").item_id = id
	desc.get_node("Choices").show()
	desc.get_node(invent_node.get_info(id, "picture")).show()
	desc.show()
	desc._start_show()
	
func _close():
	showing = false
	item_ids = []
	current_selection = 0
	counter = 0
	
	
