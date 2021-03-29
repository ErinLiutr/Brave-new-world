extends VBoxContainer

var item_id = 0
var choice_results = []

var current_selection = 0

var counter = 0

export var col = 0

var showing = false

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	
func _physics_process(delta):
	counter += 1
	
func _unhandled_key_input(event):
	if showing:
		if event.is_action_pressed("ui_down"):
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ""
			current_selection += col
			if current_selection >= choice_results.size():
				current_selection = 0
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ">"
		elif event.is_action_pressed("ui_up"):
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ""
			current_selection -= col
			if current_selection < 0:
				current_selection = choice_results.size() - 1
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ">"
		elif event.is_action_pressed("ui_right"):
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ""
			current_selection += 1
			if current_selection >= choice_results.size():
				current_selection = 0
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ">"
		elif event.is_action_pressed("ui_left"):
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ""
			current_selection -= 1
			if current_selection < 0:
				current_selection = choice_results.size() - 1
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ">"
		elif event.is_action_pressed("ui_interact") and choice_results.size() > current_selection:
			if counter > 10:
				handle_selection(current_selection)


func handle_selection(_current_selection):
	var destination = choice_results[_current_selection]
	close()
	get_node("GridContainer").handle_selection(destination, item_id)
	
func close():
	hide()
	showing = false
	var choices = get_node("GridContainer")
	choice_results = []
	for i in choices.get_children():
		choices.remove_child(i)
		i.queue_free()
