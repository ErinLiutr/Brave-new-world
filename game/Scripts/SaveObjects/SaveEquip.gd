extends Control

func save():
	var save_dict = {
		"filename": "Equipment"
	}
	for c in get_children():
		save_dict[c.name] = c.visible
	return save_dict

func load_dict(dict):
	for c in get_children():
		c.visible = dict[c.name]
