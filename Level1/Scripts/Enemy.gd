extends KinematicBody2D

var velocity = Vector2(300, 0)
var life_points = 100
var pop_up
onready var animationPlayer = null

func _ready():
	animationPlayer = $"BleedingAnimator"
	$"Bleeding".visible = false
	pop_up = get_node("../../PopupWin/PopupMenu")
	$"-1/Sprite".visible = false
	$"-10/Sprite".visible = false
	$"-20/Sprite".visible = false
	$"-30/Sprite".visible = false
	$"-40/Sprite".visible = false
func lose_10():
	$"-10/Sprite".visible = true
	$"-10/AnimationPlayer".play("-1")
	
func lose_20():
	$"-20/Sprite".visible = true
	$"-20/AnimationPlayer".play("-1")

func lose_30():
	print("hi")
	$"-30/Sprite".visible = true
	$"-30/AnimationPlayer".play("-1")
	
func lose_40():
	$"-40/Sprite".visible = true
	$"-40/AnimationPlayer".play("-1")	
	
func lose_life(flag):
	life_points -= 1
	if (life_points >= 0):
		$"../../Label".set_text("HP: "+str(life_points))
	$"Bleeding".visible = true
	animationPlayer.play("Bleeding")
	if flag:
		$"-1/Sprite".visible = true
		$"-1/AnimationPlayer".play("-1")	
		
		
func _physics_process(delta):
	if life_points <= 0:
		$"../Player".stop_player()
		set_physics_process(false)
		set_process(false)
		$"../../Win".visible = true
		$"../../Win".start()
