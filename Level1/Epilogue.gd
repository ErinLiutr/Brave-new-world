extends Node2D

var title_scene
var prologue_scene = preload("res://Prologue.tscn")

func _return():
	var TheRoot = get_node("/root")
	var this_scene = get_node("/root/Epilogue")
	TheRoot.remove_child(this_scene)
	title_scene.get_node("Sound2/NinePatchRect/HSlider").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	TheRoot.add_child(title_scene)
	
func _progress():
	var TheRoot = get_node("/root")
	var this_scene = get_node("/root/Epilogue")
	var next_scene = prologue_scene.instance()
	next_scene.title_scene = this_scene
	next_scene.get_node("YSort/Player/Camera2D/Guide")._start_show()
	next_scene.get_node("YSort/Player").canMove = false
	TheRoot.remove_child(this_scene)
	TheRoot.add_child(next_scene)
	next_scene.get_node("YSort/Player/Camera2D/Sound/NinePatchRect/HSlider").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	next_scene.get_node("YSort/Player/Camera2D/Inventory").item_ids = []
	
func _start(id):
	print(id)
	get_node("bed/Player")._start_play(id)
