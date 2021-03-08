extends Button

export var path = "res://Room.tscn"

func _ready():
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("pressed", self, "_on_Button_Pressed")
	

func _on_Button_Pressed():
#	if (path != ""):
	get_tree().change_scene("res://Room.tscn")
#	else:
#		get_tree().quit()
