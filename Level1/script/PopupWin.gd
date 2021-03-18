extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_TextureButton_pressed():
func _input(event):
	if event is InputEventKey and event.scancode == KEY_C and get_parent().get_parent().get_node("Password").popup:
		get_node("PopupMenu").hide()
		get_node("/root/Room/YSort/Player/Camera2D/Password")._stop_show()
		get_node("/root/Room/YSort/table/bottle/Interact").status = 1
