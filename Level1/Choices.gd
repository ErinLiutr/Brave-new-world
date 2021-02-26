extends VBoxContainer


var choice_results = []

var current_selection = 0

var counter = 0

var showing = false

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	
func _physics_process(delta):
	counter += 1
	
func _unhandled_key_input(event):
	if showing:
		if event.is_action_pressed("ui_down") and current_selection + 2 < choice_results.size():
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ""
			current_selection += 2
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ">"
		elif event.is_action_pressed("ui_up") and current_selection >= 2:
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ""
			current_selection -= 2
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ">"
		elif event.is_action_pressed("ui_right") and current_selection + 1 < choice_results.size():
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ""
			current_selection += 1
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ">"
		elif event.is_action_pressed("ui_left") and current_selection >= 1:
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ""
			current_selection -= 1
			get_node("GridContainer/choice" + str(current_selection) + "/selector").text = ">"
		elif event.is_action_pressed("ui_interact") and choice_results.size() > current_selection:
			handle_selection(current_selection)
	


func handle_selection(_current_selection):
	hide()
	showing = false
	var choices = get_node("GridContainer")
	var destination = choice_results[_current_selection]
	choice_results = []
	for i in choices.get_children():
		choices.remove_child(i)
		i.queue_free()
	get_parent()._start(destination)
