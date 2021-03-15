extends Sprite

var showing = false

var pressed = false
var counter = 0

func _start_show():
	showing = true

func _stop_show():
	counter = 0
	get_node("Choices/Description").text = ""
	for node in get_children():
		if node.name != "Choices":
			node.hide()
	hide()
	showing = false
	get_node("Choices").close()
	if get_parent().name == "Camera2D":
		get_node("/root/Room/YSort/Player").canMove = true
	else:
		get_parent().get_node("NinePatchRect/GridContainer").showing = true
		get_parent().showing = true
