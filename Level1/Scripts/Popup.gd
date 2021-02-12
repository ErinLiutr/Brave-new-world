extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Replay_pressed():
	get_tree().change_scene("res://world.tscn")

func _on_Continue_pressed():
	pass # Replace with function body.
