extends KinematicBody2D

const BALL = preload("res://Scene/Ball.tscn")
const REPORT = preload("res://Scene/Bullet_report.tscn")
const MAG = preload("res://Scene/Bullet_magazine.tscn")
const GIFT = preload("res://Scene/Bullet_gift.tscn")
const DYE = preload("res://Scene/Bullet_dye.tscn")
var lives = [get_node("../../PlayerLives/Life1"),
			get_node("../../PlayerLives/Life2"),
			get_node("../../PlayerLives/Life3"),
			get_node("../../PlayerLives/Life4"),
			get_node("../../PlayerLives/Life5"),
			get_node("../../PlayerLives/Life6")]
export var maxSpeed = 400
export var acceleration = 2000
export var friction = 10000

var axis = Vector2.ZERO
var velocity = Vector2.ZERO
var life_points = 6
var pop_up
var bullet_type

func _ready():
	pop_up = get_node("../../PopupLose/PopupMenu")
	bullet_type = "bullet"
	
func _physics_process(delta):
	get_input_axis()
	if(axis) == Vector2.ZERO:
		apply_friction(friction*delta)
	else:
		apply_motion(acceleration*delta)
		
	velocity = move_and_slide(velocity)
	if life_points <= 0:
		stop_player()
		pop_up.rect_global_position = Vector2(50, 250)
		pop_up.show()
		
func stop_player():
	print("player stop")
	$"../Enemy/BulletSpawner".stop()
	for c in $"../../Bag/Grid".get_children():
		c.stop()
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
	velocity += axis.normalized()*acc_factor
	velocity = velocity.clamped(maxSpeed)

func lose_life():
	life_points = max(0, life_points - 1)
	var life = get_node("../../PlayerLives/Life%d"%(life_points+1))
	get_node("../../PlayerLives/Life%d/Vanish"%(life_points+1)).play("Vanish")
	
func change_bullet(type):
	bullet_type = type
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
				var direction = Vector2(0, -1)
				var ball
				if bullet_type == "bullet":
					ball = BALL.instance()
				if bullet_type == "dye":
					ball = DYE.instance()
					bullet_type = "bullet"
				if bullet_type == "magazine":
					ball = MAG.instance()
					bullet_type = "bullet"
				if bullet_type == "report":
					ball = REPORT.instance()
					bullet_type = "bullet"
				if bullet_type == "gift":
					ball = GIFT.instance()
					bullet_type = "bullet"
					
				get_parent().add_child(ball)
				ball.global_position = global_position + (30*direction)
				ball.set_bullet_direction( direction)
