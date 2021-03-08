extends Node2D

var item_ids = [215, 213, 208, 211]

var showing = false
var pressed = false
var counter = 0

var json
var script_url = "res://items.json"
var inventory_item = preload("res://InventItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	json = load_data(script_url)

func load_data(url):
	var file = File.new()
	if url == null: return null
	if !file.file_exists(url): return null
	file.open(url, File.READ)
	var data = {}
	data = parse_json(file.get_as_text())
	file.close()
	return data
	

func init():
	var idx = 0
	get_node("NinePatchRect/GridContainer").item_ids = []
	for id in item_ids:
		var new_item = inventory_item.instance()
		new_item.name = str(id)
		if idx == 0:
			new_item.get_node("selected").show()
		else:
			new_item.get_node("selected").hide()
			new_item.get_node("unselected").show()
		idx += 1
		get_node("NinePatchRect/GridContainer").item_ids.append(str(id))
		new_item.get_node(json[str(id)]["picture"]).show()

		get_node("NinePatchRect/GridContainer").add_child(new_item)
	get_node("NinePatchRect/GridContainer").current_selection = 0
	get_node("/root/Room/YSort/Player").canMove = false
	get_node("NinePatchRect/GridContainer").showing = true
	
func get_info(id, key):
	print(json[str(id)])
	return json[str(id)][key]
		
func _unhandled_key_input(event):
	if showing:
		if event.is_action_pressed("ui_cancel"):
			pressed = true
		elif event.is_action_released("ui_cancel"):
			pressed = false
		
func _physics_process(delta):
	if showing:
		counter += 1
		if pressed and counter > 10:
			_stop_show()
	pressed = false

func _start_show():
	init()
	showing = true
	show()
	
func _stop_show():
	counter = 0
	var items = get_node("NinePatchRect/GridContainer")
	for i in items.get_children():
		items.remove_child(i)
		i.queue_free()
	items._close()
	hide()
	get_node("/root/Room/YSort/Player").canMove = true
	showing = false
