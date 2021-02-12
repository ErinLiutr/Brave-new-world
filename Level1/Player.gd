extends KinematicBody2D

var direction = Vector2(0, 0)
var startPos = position
var moving = false

var canMove = true
var pressed = false

const SPEED = 1
const GRID = 16

var world
var sprite
var animationPlayer

func _ready():
	world = get_world_2d().get_direct_space_state()
	set_physics_process(true)
	sprite = get_node("Sprite")
	animationPlayer = get_node("AnimationPlayer")
	
func _input(event):
	if event.is_action_pressed("ui_interact"):
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false
func _physics_process(delta):
	if !moving and canMove:
		var resultUp = world.intersect_point(position + Vector2(0, -GRID))
		var resultDown = world.intersect_point(position + Vector2(0, GRID))
		var resultLeft = world.intersect_point(position + Vector2(-GRID, 0))
		var resultRight = world.intersect_point(position + Vector2(GRID, 0))
		
		
		if Input.is_action_pressed("ui_up"):
			sprite.set_frame(8)
			if resultUp.empty():
				moving = true
				direction = Vector2(0, -1)
				startPos = position
				animationPlayer.play("RunUp")
		elif Input.is_action_pressed("ui_down"):
			sprite.set_frame(0)
			if resultDown.empty():
				moving = true
				direction = Vector2(0, 1)
				startPos = position
				animationPlayer.play("RunDown")
		elif Input.is_action_pressed("ui_left"):
			sprite.set_frame(4)
			if resultLeft.empty():
				moving = true
				direction = Vector2(-1, 0)
				startPos = position
				animationPlayer.play("RunLeft")
		elif Input.is_action_pressed("ui_right"):
			sprite.set_frame(12)
			if resultRight.empty():
				moving = true
				direction = Vector2(1, 0)
				startPos = position
				animationPlayer.play("RunRight")
		
		if pressed:
			if sprite.get_frame() == 0:
				interact(resultDown)
			elif sprite.get_frame() == 4:
				interact(resultLeft)
			elif sprite.get_frame() == 8:
				interact(resultUp)
			elif sprite.get_frame() == 12:
				interact(resultRight)
	elif canMove:
		move_and_collide(direction * SPEED)
		var diff = position - (startPos + Vector2(GRID * direction.x, GRID * direction.y))

		if abs(diff.x) < 0.1 && abs(diff.y) < 0.1:
			moving = false
	pressed = false
			
func interact(result):
	for dictionary in result:
		if typeof(dictionary.collider) == TYPE_OBJECT and (dictionary.collider.has_node("Interact")):
			canMove = false
			dictionary.collider.get_node("Interact").show()
			if dictionary.collider.has_node("Interact/Game"):
				get_node("/root/Room/cabinet2/StaticBody2D/blur").show()
			if dictionary.collider.has_node("Interact/RichTextLabel"):
				dictionary.collider.get_node("Interact")._print_dialogue()
			else:
				dictionary.collider.get_node("Interact")._start_show()
