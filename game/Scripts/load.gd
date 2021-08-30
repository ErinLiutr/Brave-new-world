extends Node2D

var title_scene

var corridor_scene = preload("res://Corridor.tscn")

export var player_path = ""
export var scene_path = ""

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if !node.has_method("save"):
			continue
		var node_data = node.call("save")
		save_game.store_line(to_json(node_data))
	save_game.close()
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return 
	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		if (node_data["filename"] in ["shirt", "bandage", "dye", "bleach", "hair", "gift", "magazine"]):
			var node = get_tree().get_nodes_in_group("Persist")
			for n in node:
				if n.name == node_data["filename"]:
					n.visible = node_data["visible"]
		if (node_data["filename"] == "Inventory"):
			var node = get_tree().get_nodes_in_group("Persist")
			for n in node:
				if n.name == node_data["filename"]:
					n.item_ids = node_data["items"]

		if (node_data["filename"] == "Equipment"):
			$"YSort/Player/Camera2D/Equipment".load_dict(node_data)

	save_game.close()

func help():
	get_node(player_path).canMove = false
	get_node(player_path + "/Help").show()
	
func _progress():
	var TheRoot = get_node("/root")
	var this_scene = get_node(scene_path)
	var next_scene = corridor_scene.instance()
	next_scene.title_scene = title_scene
	#next_scene.get_node("YSort/Player").canMove = false
	var item_name
	if this_scene.get_node("YSort/Player").equipment == "0" or this_scene.get_node("YSort/Player").equipment == "":
		item_name = "0"
	else:
		item_name = this_scene.get_node("YSort/Player/Camera2D/Inventory").get_info(this_scene.get_node("YSort/Player").equipment, "picture")
	next_scene.get_node("YSort/Player").equipment = this_scene.get_node("YSort/Player").equipment
	next_scene.get_node("YSort/Player").set_equip(item_name)
	next_scene.get_node("YSort/Player/Sprite").set_frame(8)
	next_scene.get_node("YSort/Player/Camera2D/Sound/NinePatchRect/HSlider").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	next_scene.get_node("YSort/Player/Camera2D/Inventory").item_ids = get_node("YSort/Player/Camera2D/Inventory").item_ids
	TheRoot.remove_child(this_scene)
	TheRoot.add_child(next_scene)
	MusicController.play_ambience()
	#next_scene.get_node("YSort/Player/Camera2D/Chapter2")._play_fadeout()
	
func _return():
	var TheRoot = get_node("/root")
	var this_scene = get_node(scene_path)
	TheRoot.remove_child(this_scene)
	title_scene.get_node("Sound2/NinePatchRect/HSlider").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	TheRoot.add_child(title_scene)
	MusicController.play_title()

