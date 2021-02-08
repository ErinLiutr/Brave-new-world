extends KinematicBody2D

const BALL = preload("res://Scene/Ball.tscn")
const BULLET = preload("res://Scene/Bullet.tscn")
export var maxSpeed = 500
export var acceleration = 2000
export var friction = 10000

var axis = Vector2.ZERO
var velocity = Vector2.ZERO
var life_points = 5
var pop_up

func _ready():
	pop_up = get_node("../../Popup/PopupMenu")

func _physics_process(delta):
	get_input_axis()
	if(axis) == Vector2.ZERO:
		apply_friction(friction*delta)
	else:
		apply_motion(acceleration*delta)
		
	velocity = move_and_slide(velocity)
	if life_points <= 0:
		stop_player()
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
	
func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			if event.position != position:
#				# from player position to mouse position
#				var direction = (event.global_position - global_position).normalized()
#				var ball = BALL.instance()
#				# add ball as child to the scene
#				print(get_parent().name)
#				get_parent().add_child(ball)
#				ball.global_position = Vector2(100, 100)#global_position + (30*direction)
#				ball.set_ball_direction(direction)

	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
				var direction = Vector2(0, -1)
				var ball = BALL.instance()

				get_parent().add_child(ball)
				ball.global_position = global_position + (30*direction)
				ball.set_ball_direction(direction)
