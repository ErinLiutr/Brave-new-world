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


func _on_TextureButton_pressed():
	get_node("PopupMenu").hide()
	get_node("/root/Room/YSort/Player/Camera2D/Password")._stop_show()
	get_node("/root/Room/YSort/table/bottle/Interact").status = 1