extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _on_TextureButton_pressed():
func _input(event):
	if event is InputEventKey and event.scancode == KEY_T and get_parent().get_parent().get_node("Password").popup:
		get_node("PopupMenu").hide()
		get_node("/root/Room/YSort/Player/Camera2D/Password")._reset()
