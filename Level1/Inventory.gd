extends Node2D

var item_ids = []

export var player_path = ""

var showing = false
var pressed = false
var counter = 0
var show_guide = false

var json
var script_url = "res://items.json"
var inventory_item = preload("res://InventItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	json = load_data(script_url)

func save():
	var save_dict = {
		"filename": "Inventory",
		"items": item_ids
	}
	return save_dict
	
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
#	if (get_node("NinePatchRect/GridContainer").item_ids != ):
	get_node("NinePatchRect/GridContainer").item_ids = []
	for id in item_ids:
		if id == "414":
			continue
		var new_item = inventory_item.instance()
		new_item.name = str(id)
		new_item.get_node("unequip").hide()
		if idx == 0:
			new_item.get_node("selected").show()
		else:
			new_item.get_node("unselected").show()
		idx += 1
		get_node("NinePatchRect/GridContainer").item_ids.append(str(id))
		new_item.get_node(json[str(id)]["picture"]).show()

		get_node("NinePatchRect/GridContainer").add_child(new_item)
	get_node("NinePatchRect/GridContainer").current_selection = 0
	get_node(player_path).canMove = false
	get_node("NinePatchRect/GridContainer").showing = true
	
func get_info(id, key):
	return json[str(id)][key]
	
func combine(id):
	var combine_info = get_info(id, "combine")
	var to = combine_info["to"]
	var node = get_node(get_info(id, "path") + "/Interact")
	node.id = to
	
	var with = combine_info["with"]
	var with_to = get_info(with, "combine")["to"]
	var idx = item_ids.find(with)
	item_ids.remove(idx)
	item_ids.insert(idx, with_to)
	get_node(player_path).equipment = with_to
	get_node(player_path).update_equip(json[with]["picture"], json[with_to]["picture"])

	if with_to == "206":
		get_node("/root/Room/YSort/Player/Camera2D/DialogBox")._start("20")
		get_node("/root/Room/YSort/Player").canMove = false
		get_node("/root/Room/YSort/Player/Camera2D/DialogBox").show()
		if item_ids.has("206") and item_ids.has("207") and item_ids.has("208") and item_ids.has("213"):
			get_node("/root/Room/YSort/Player/Camera2D/DialogBox").next_dialog = "24"
		
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
	show()
	if show_guide:
		get_node("../Guide2")._stop_show()
		get_node("../Guide3")._start_show()
	showing = true
	
func _stop_show():
	counter = 0
	var items = get_node("NinePatchRect/GridContainer")
	for i in items.get_children():
		items.remove_child(i)
		i.queue_free()
	items._close()
	hide()
	print("3")
	get_node(player_path).canMove = true
	showing = false
