extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var button = get_node("Sound").get_close_button()

# Called when the node enters the scene tree for the first time.
func _ready():
	button.connect("pressed", self, "close")


func close():
	get_node("/root/Room/YSort/Player").canMove = true


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
