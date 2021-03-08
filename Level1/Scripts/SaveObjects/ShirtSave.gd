extends StaticBody2D

func save():
	var save_dict = {
		"visible": visible
	}
	print("hi!")
	print(visible)
	return save_dict
