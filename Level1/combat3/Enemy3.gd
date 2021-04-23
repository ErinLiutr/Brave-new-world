extends KinematicBody2D

var velocity = Vector2(30, 0)
var life_points = 200
var pop_up
onready var animationPlayer = null
var incr = 0.001
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
		
func stop():
	set_physics_process(false)
	set_process(false)
		
func _physics_process(delta):
	$"../../EnemyLifeBar".set_value(life_points)
	var collision = move_and_collide(velocity*delta)
	if (self.position.x > 550 or self.position.x < 0):
		self.velocity = Vector2(self.velocity.x*-1, self.velocity.y)
	self.velocity = Vector2(self.velocity.x+incr, self.velocity.y)
	if life_points <= 0:
		$"../Player".stop_player()
		set_physics_process(false)
		set_process(false)
		$"../../Win".visible = true
		$"../../Win".start()
