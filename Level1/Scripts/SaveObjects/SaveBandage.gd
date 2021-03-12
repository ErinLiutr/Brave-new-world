extends StaticBody2D

func save():
	var save_dict = {
		"filename": "bandage",
		"visible": visible
	}
	return save_dict
