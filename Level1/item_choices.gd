extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var invent_node

# Called when the node enters the scene tree for the first time.
func _ready():
	invent_node = get_node("/root/Room/YSort/Player/Camera2D/Inventory")


func handle_selection(destination, id):
	get_parent().get_parent()._stop_show()
	if destination == "slidingPuzzle":
		get_node("/root/Room/YSort/Player/Camera2D/blur").show()
		get_node("/root/Room/YSort/Player/Camera2D/Puzzle")._start_show()
		get_node("/root/Room/YSort/Player").canMove = false
	elif destination == "pick":
		var path = invent_node.get_info(id, "path")
		var node = get_node(path)
		if node.has_node("CollisionShape2D"):
			node.get_node("CollisionShape2D").disabled = true
		node.hide()
		invent_node.item_ids.append(str(id))
	
	elif destination == "equip":
		get_node("/root/Room/YSort/Player").equipment = str(id)

		var equip_node = get_node("/root/Room/YSort/Player/Camera2D/Equipment/")
		for child in equip_node.get_children():
			if child.name != "selected":
				child.hide()
		var picture = invent_node.get_info(id, "picture")
		get_node("/root/Room/YSort/Player/Camera2D/Equipment/" + picture).show()
	elif destination == "combine":
		invent_node.combine(id)
