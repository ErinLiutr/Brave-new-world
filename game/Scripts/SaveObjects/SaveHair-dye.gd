extends StaticBody2D

func save():
	var save_dict = {
		"filename": "dye",
		"visible": visible
	}
	return save_dict
