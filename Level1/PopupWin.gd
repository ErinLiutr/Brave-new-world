extends Control


func _on_TextureButton_pressed():
	# return to main scene
	get_node("PopupPanel").hide()
	get_parent().get_parent().get_node("Puzzle")._stop_show()
	get_node("/root/Room/cabinet3/cabinet2/Interact").id = "208"
	
