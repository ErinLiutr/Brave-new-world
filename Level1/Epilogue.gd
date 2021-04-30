extends Node2D

var title_scene
var id

func _return():
	var TheRoot = get_node("/root")
	var this_scene = get_node("/root/Epilogue")
	TheRoot.remove_child(this_scene)
	title_scene.get_node("Sound2/NinePatchRect/HSlider").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	TheRoot.add_child(title_scene)
	
func _start_play():
	get_node("bed/Player/Camera2D/Ending")._play_fadeout()
	
func _start():
	get_node("bed/Player")._start_play(id)
