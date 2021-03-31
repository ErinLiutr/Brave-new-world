extends Node2D

var state = [-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] 
var map = [[4, 8],[3, 6],[1, 5, 9],
		   [2, 3, 5],[2, 7, 10],[6, 8, 9]]
var on = "res://hair-dye.png"
var off = "res://hair-bleach.png"

func _input(event):
	if Input.is_key_pressed(KEY_R):
		state = [-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		for i in range (1, 11):
			get_node("NinePatchRect/off%d"%i).texture = load(off)
	
	if Input.is_key_pressed(KEY_C):
		state = [-1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
		for i in range (1, 11):
			get_node("NinePatchRect/off%d"%i).texture = load(on)
						
	if Input.is_key_pressed(KEY_1):
		for i in map[0]:
			if (state[i] == 0):
				get_node("NinePatchRect/off%d"%i).texture = load(on)
			else:
				get_node("NinePatchRect/off%d"%i).texture = load(off)
			state[i] = 1-state[i]
	if Input.is_key_pressed(KEY_2):
		for i in map[1]:			
			if (state[i] == 0):
				get_node("NinePatchRect/off%d"%i).texture = load(on)
			else:
				get_node("NinePatchRect/off%d"%i).texture = load(off)			
			state[i] = 1-state[i]
	if Input.is_key_pressed(KEY_3):
		for i in map[2]:			
			if (state[i] == 0):
				get_node("NinePatchRect/off%d"%i).texture = load(on)
			else:
				get_node("NinePatchRect/off%d"%i).texture = load(off)			
			state[i] = 1-state[i]
	if Input.is_key_pressed(KEY_4):
		for i in map[3]:			
			if (state[i] == 0):
				get_node("NinePatchRect/off%d"%i).texture = load(on)
			else:
				get_node("NinePatchRect/off%d"%i).texture = load(off)			
			state[i] = 1-state[i]	
	if Input.is_key_pressed(KEY_5):
		for i in map[4]:			
			if (state[i] == 0):
				get_node("NinePatchRect/off%d"%i).texture = load(on)
			else:
				get_node("NinePatchRect/off%d"%i).texture = load(off)			
			state[i] = 1-state[i]
	if Input.is_key_pressed(KEY_6):
		for i in map[5]:
			if (state[i] == 0):
				get_node("NinePatchRect/off%d"%i).texture = load(on)
			else:
				get_node("NinePatchRect/off%d"%i).texture = load(off)			
			state[i] = 1-state[i]
