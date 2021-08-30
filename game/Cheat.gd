extends Button


func _ready():
	connect("pressed", self, "_on_Button_Pressed")


func _on_Button_Pressed():
	get_parent().get_node("Confirm").show()
