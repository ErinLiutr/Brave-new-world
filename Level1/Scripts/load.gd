extends Node2D

var title_scene

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
	get_node("/root/Room/YSort/Player").canMove = false
	get_node("/root/Room/YSort/Player/Help").show()
	
func _return():
	var TheRoot = get_node("/root")
	var this_scene = get_node("/root/Room")
	TheRoot.remove_child(this_scene)
	title_scene.get_node("Sound2/NinePatchRect/HSlider").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	TheRoot.add_child(title_scene)
