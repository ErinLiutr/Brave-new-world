extends Button


func _ready():
	connect("mouse_entered", self, "_on_Button_mouse_entered")
	connect("pressed", self, "_on_Button_Pressed")
	

func _on_Button_Pressed():
	get_node("../Chapter")._open_menu()
