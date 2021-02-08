extends KinematicBody2D

var velocity = Vector2(300, 0)
var life_points = 100
var pop_up_win


func _ready():
	pop_up_win = get_node("../../PopupWin/PopupMenu")

func lose_life():
	life_points -= 1

func _physics_process(delta):
	if life_points <= 0:
		$"../Player".stop_player()
		set_physics_process(false)
		set_process(false)
		pop_up_win.show()
