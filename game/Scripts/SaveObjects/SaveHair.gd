extends StaticBody2D

func save():
	var save_dict = {
		"filename": "hair",
		"visible": visible
	}
	return save_dict
