extends StaticBody2D

func save():
	var save_dict = {
		"filename": "magazine",
		"visible": visible
	}
	return save_dict
