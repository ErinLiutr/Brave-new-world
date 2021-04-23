extends Node2D

var state = [-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] 
var switch_state = [-1, 0, 0, 0, 0, 0, 0]
var map = [[4, 8],[3, 6],[1, 5, 9],
		   [2, 3, 5],[2, 7, 10],[6, 8, 9]]
var on = "res://on.png"
var off = "res://off.png"
var s_on = "res://switch_on.png"
var s_off = "res://switch_off.png"
var showing = false

func _ready():
	for i in range (1, 11):
			get_node("NinePatchRect/off%d"%i).texture = load(off)
	for i in range (1, 7):
			get_node("switches/s%d"%i).texture = load(s_off)

func _input(event):
	if true:
		if Input.is_key_pressed(KEY_R):
			state = [-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
			for i in range (1, 11):
				get_node("NinePatchRect/off%d"%i).texture = load(off)
			for i in range (1, 7):
				get_node("switches/s%d"%i).texture = load(s_off)

		if Input.is_key_pressed(KEY_C):
			state = [-1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			for i in range (1, 11):
				get_node("NinePatchRect/off%d"%i).texture = load(on)
			for i in [1, 2, 3, 5]:
				get_node("switches/s%d"%i).texture = load(s_on)
			for i in [4, 6]:
				get_node("switches/s%d"%i).texture = load(s_off)
		if Input.is_key_pressed(KEY_1):
			for i in map[0]:
				if (state[i] == 0):
					get_node("NinePatchRect/off%d"%i).texture = load(on)
				else:
					get_node("NinePatchRect/off%d"%i).texture = load(off)
				state[i] = 1-state[i]
			if (switch_state[1] == 0):
				get_node("switches/s1").texture = load(s_on)
				switch_state[1] = 1
			else:
				get_node("switches/s1").texture = load(s_off)
				switch_state[1] = 0

		if Input.is_key_pressed(KEY_2):
			for i in map[1]:			
				if (state[i] == 0):
					get_node("NinePatchRect/off%d"%i).texture = load(on)
				else:
					get_node("NinePatchRect/off%d"%i).texture = load(off)			
				state[i] = 1-state[i]
			if (switch_state[2] == 0):
				get_node("switches/s2").texture = load(s_on)
				switch_state[2] = 1
			else:
				get_node("switches/s2").texture = load(s_off)
				switch_state[2] = 0

		if Input.is_key_pressed(KEY_3):
			for i in map[2]:			
				if (state[i] == 0):
					get_node("NinePatchRect/off%d"%i).texture = load(on)
				else:
					get_node("NinePatchRect/off%d"%i).texture = load(off)			
				state[i] = 1-state[i]
			if (switch_state[3] == 0):
				get_node("switches/s3").texture = load(s_on)
				switch_state[3] = 1
			else:
				get_node("switches/s3").texture = load(s_off)
				switch_state[3] = 0

		if Input.is_key_pressed(KEY_4):
			for i in map[3]:			
				if (state[i] == 0):
					get_node("NinePatchRect/off%d"%i).texture = load(on)
				else:
					get_node("NinePatchRect/off%d"%i).texture = load(off)			
				state[i] = 1-state[i]	
			if (switch_state[4] == 0):
				get_node("switches/s4").texture = load(s_on)
				switch_state[4] = 1
			else:
				get_node("switches/s4").texture = load(s_off)
				switch_state[4] = 0

		if Input.is_key_pressed(KEY_5):
			for i in map[4]:			
				if (state[i] == 0):
					get_node("NinePatchRect/off%d"%i).texture = load(on)
				else:
					get_node("NinePatchRect/off%d"%i).texture = load(off)			
				state[i] = 1-state[i]

			if (switch_state[5] == 0):
				get_node("switches/s5").texture = load(s_on)
				switch_state[5] = 1
			else:
				get_node("switches/s5").texture = load(s_off)
				switch_state[5] = 0

		if Input.is_key_pressed(KEY_6):
			for i in map[5]:
				if (state[i] == 0):
					get_node("NinePatchRect/off%d"%i).texture = load(on)
				else:
					get_node("NinePatchRect/off%d"%i).texture = load(off)			
				state[i] = 1-state[i]
			if (switch_state[6] == 0):
				get_node("switches/s6").texture = load(s_on)
				switch_state[6] = 1
			else:
				get_node("switches/s6").texture = load(s_off)
				switch_state[6] = 0

func start_show():
	showing = true
	show()
	
func stop_show():
	showing = false
	hide()
