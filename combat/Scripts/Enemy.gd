extends KinematicBody2D

var velocity = Vector2(300, 0)
var life_points = 100
var pop_up
onready var animationPlayer = null

func _ready():
	animationPlayer = $"BleedingAnimator"
#	animationPlayer.play("Idle")
	$"Bleeding".visible = false
	pop_up = get_node("../../PopupWin/PopupMenu")
	
func lose_life():
	life_points -= 1
	$"Bleeding".visible = true
	animationPlayer.play("bleeding")
#	$"Bleeding".visible = false
	
func _physics_process(delta):
	if life_points <= 0:
		$"../Player".stop_player()
		set_physics_process(false)
		set_process(false)
		pop_up.rect_global_position = Vector2(350, 180)
		pop_up.show()

