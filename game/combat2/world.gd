extends Node2D

var previous_scene
var combat_scene = preload("res://Scene/world.tscn")
var counter = 0
var enter_count = 0

func _input(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		$"Guide".visible = false
		_return(false)
	elif event is InputEventKey and event.scancode == KEY_ENTER:
		if enter_count < 2:
			enter_count += 1
		else:
			$"Guide".visible = false
		
func _return(win):
	var TheRoot = get_node("/root")
	var this_scene = get_node("/root/Combat")
	TheRoot.remove_child(this_scene)
	TheRoot.add_child(previous_scene)
	previous_scene.get_node("YSort/Player").canMove = true
	if win:
		previous_scene.get_node("YSort/Player/Camera2D/DialogBox").show()
		previous_scene.get_node("YSort/Player/Camera2D/DialogBox")._start("08")
		previous_scene.get_node("YSort/Player").canMove = false

func _restart():
	var this_scene = self.get_node("World")
	var next_scene = combat_scene.instance()
	self.remove_child(this_scene)
	self.add_child(next_scene)
