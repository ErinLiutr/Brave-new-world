extends Control
var choice_item = preload("res://Choice.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.scancode == KEY_Q:
		var TheRoot = get_node("/root")
		var this_scene = TheRoot.get_node("Control")
		var combat_scene = load("res://Room.tscn")
		var next_scene = combat_scene.instance()
		TheRoot.remove_child(this_scene)
		TheRoot.add_child(next_scene)
		TheRoot.get_node("Room").load_game()
	if event is InputEventKey and event.scancode == KEY_R:
		get_tree().change_scene("res://Scene/world.tscn")
