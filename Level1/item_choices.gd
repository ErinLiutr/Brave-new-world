extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func handle_selection(destination, path, id, picture, combine_to):
	get_parent().get_parent()._stop_show()
	if destination == "slidingPuzzle":
		get_node("/root/Room/YSort/Player/Camera2D/blur").show()
		get_node("/root/Room/YSort/Player/Camera2D/Puzzle")._start_show()
		get_node("/root/Room/YSort/Player").canMove = false
	elif destination == "pick":

		var node = get_node(path)
		node.get_parent().remove_child(node)
		node.queue_free()
		get_node("/root/Room/YSort/Player/Camera2D/Inventory").item_ids.append(str(id))
	
	elif destination == "equip":
		get_node("/root/Room/YSort/Player").equipment = str(id)

		var equip_node = get_node("/root/Room/YSort/Player/Camera2D/Equipment/")
		for child in equip_node.get_children():
			if child.name != "selected":
				child.hide()
		get_node("/root/Room/YSort/Player/Camera2D/Equipment/" + picture).show()
