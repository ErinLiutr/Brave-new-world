extends Node2D
var txtLabel

func _on_LineEdit_text_entered(new_text):
	txtLabel = get_node("LineEdit").text

func _physics_process(delta):
	if (txtLabel == "7031"):
		print('done!')
