extends Button

var room_scene = preload("res://Room.tscn")

func _ready():
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("pressed", self, "_on_Button_Pressed")
	

func _on_Button_Pressed():
	var TheRoot = get_node("/root")
	var this_scene = TheRoot.get_node("Title")
	var next_scene = room_scene.instance()
	next_scene.title_scene = this_scene
	TheRoot.remove_child(this_scene)
	TheRoot.add_child(next_scene)
