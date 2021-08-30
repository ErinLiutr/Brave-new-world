extends KinematicBody2D

const BALL = preload("res://combat3/Ball.tscn")
const REPORT = preload("res://Scene/Bullet_report.tscn")
const MAG = preload("res://Scene/Bullet_magazine.tscn")
const GIFT = preload("res://Scene/Bullet_gift.tscn")
const DYE = preload("res://Scene/Bullet_dye.tscn")
var lives = [get_node("../../PlayerLives/Life1"),
			get_node("../../PlayerLives/Life2"),
			get_node("../../PlayerLives/Life3"),
			get_node("../../PlayerLives/Life4"),
			get_node("../../PlayerLives/Life5"),
			get_node("../../PlayerLives/Life6"),
			get_node("../../PlayerLives/Life7"),
			get_node("../../PlayerLives/Life8"),
			get_node("../../PlayerLives/Life9"),
			get_node("../../PlayerLives/Life10"),
			get_node("../../PlayerLives/Life11"),
			get_node("../../PlayerLives/Life12")]
const WIN = 100
export var maxSpeed = 60
export var acceleration = 200
export var friction = 200
var disable = false
var axis = Vector2.ZERO
var velocity = Vector2.ZERO
var life_points = 12
var points = 0

func _physics_process(delta):
	$"../../Scores".set_value(points)
	get_input_axis()
	if(axis) == Vector2.ZERO:
		apply_friction(friction*delta)
	else:
		apply_motion(acceleration*delta)
		
	velocity = move_and_slide(velocity)
			
	if (points >= WIN):
		stop_player()
		$"../Enemy".stop()
		$"../Enemy/BulletSpawner".stop()
		$"../../ExtraLives".stop()
		$"../../Win".visible = true
		$"../../Win".start()
	
	if (life_points <=0):
		stop_player()
		$"../Enemy".stop()
		$"../Enemy/BulletSpawner".stop()
		$"../../ExtraLives".stop()
		$"../../Lose".visible = true
		$"../../Lose".start()

func stop_player():
	$"../Enemy/BulletSpawner".stop()
	for c in $"../../Bag/Grid".get_children():
		c.stop()
	disable = true
	set_physics_process(false)
	set_process(false)
	
	
func get_input_axis():
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

func apply_friction(friction_factor):
	if (velocity.length() > friction_factor):
		velocity -= velocity.normalized()*friction_factor
	else:
		velocity = Vector2.ZERO
		
func apply_motion(acc_factor):
	velocity = axis.normalized()*maxSpeed
#	velocity += axis.normalized()*acc_factor
#	velocity = velocity.clamped(maxSpeed)

func lose_life():
	life_points = max(0, life_points - 1)
	var life = get_node("../../PlayerLives/Life%d"%(life_points+1))
	get_node("../../PlayerLives/Life%d/Vanish"%(life_points+1)).play("Vanish")
	get_node("../../PlayerLives/Life%d"%(life_points+1)).visible = false
	$AnimationPlayer.play("Bleeding")

func add_life():
	if (life_points < 12):
		get_node("../../PlayerLives/Life%d/Vanish"%(life_points+1)).play("Appear")
		get_node("../../PlayerLives/Life%d"%(life_points+1)).visible = true
		life_points += 1
		$AddLife.visible = true
		$AddLife/Timer.start()
		$ItemAudio.play()
		
func add_points(pts):
	if (pts == 1):
		$CatchBulletAudio.play()
	else:
		$ItemAudio.play()
	points = min(WIN, points + pts)
	if (points <= WIN):
		$"../../Label".set_text("SCORE: "+str(points))
		$"AddPoints".set_text("+ "+str(pts) + " points")
		$"AddPoints".visible = true
		$AddPoints/Timer.start()
#		$"SpecialAudio".play()
		
func _bullet_sound(type):
	if type=="bullet":
		$"BulletAudio".play()
	else:
		$"SpecialAudio".play()
		
#func _input(event):
#	if event is InputEventKey and event.pressed:
#		var ball
#		var direction = Vector2(0, -1)
#		if event.scancode == KEY_SPACE and disable == false:
#				ball = BALL.instance()
#				get_parent().add_child(ball)
#				ball.global_position = global_position + (30*direction)
#				ball.set_bullet_direction( direction)
#				_bullet_sound("bullet")
func fire_special(type):
	var ball
	var direction = Vector2(0, -1)
	if (type=="gift"):
		# gift
		ball = GIFT.instance()
		get_parent().add_child(ball)
		ball.global_position = global_position + (30*direction)
		ball.set_bullet_direction( direction)
	elif (type=="dye"): 
		# dye
		ball = DYE.instance()
		get_parent().add_child(ball)
		ball.global_position = global_position + (30*direction)
		ball.set_bullet_direction( direction)
	elif (type=="report"):
		# report
		ball = REPORT.instance()
		get_parent().add_child(ball)
		ball.global_position = global_position + (30*direction)
		ball.set_bullet_direction( direction)
	elif (type=="magazine"):
		# maga
		ball = MAG.instance()
		get_parent().add_child(ball)
		ball.global_position = global_position + (30*direction)
		ball.set_bullet_direction( direction)
	_bullet_sound("special")


func _on_AddLife_Timer_timeout():
	$"AddLife".visible = false


func _on_Timer_timeout():
	$"AddPoints".visible = false
