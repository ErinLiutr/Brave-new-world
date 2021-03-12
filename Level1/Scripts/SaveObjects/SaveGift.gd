extends StaticBody2D

func save():
	var save_dict = {
		"filename": "gift",
		"visible": visible
	}
	return save_dict
