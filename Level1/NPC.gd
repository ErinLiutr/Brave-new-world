extends KinematicBody2D

var direction = Vector2(0, 0)
var startPos = position
var moving = false

var animate = false

const SPEED = 1
const GRID = 16

var world
var sprite
var animationPlayer

var movement = ["down", "down", "down", "left", "left", "left", "left", "left", "left", "up", "up", "up"]
var idx = -1

func _ready():
	world = get_world_2d().get_direct_space_state()
	set_physics_process(true)
	sprite = get_node("Sprite")
	animationPlayer = get_node("AnimationPlayer")

func _physics_process(delta):
	
	if !moving and idx > -1:
		if idx == movement.size():
			idx = -1
			animate = false
			hide()
			get_parent().get_node("Wardrobe/NPC").start_animate()
		elif movement[idx] == "up":
			sprite.set_frame(8)
			moving = true
			direction = Vector2(0, -1)
			startPos = position
			animationPlayer.play("RunUp")
		elif movement[idx] == "down":
			sprite.set_frame(0)
			moving = true
			direction = Vector2(0, 1)
			startPos = position
			animationPlayer.play("RunDown")
		elif movement[idx] == "left":
			sprite.set_frame(4)
			moving = true
			direction = Vector2(-1, 0)
			startPos = position
			animationPlayer.play("RunLeft")

	elif animate:
		move_and_collide(direction * SPEED)
		var diff = position - (startPos + Vector2(GRID * direction.x, GRID * direction.y))

		if abs(diff.x) < 0.1 && abs(diff.y) < 0.1:
			moving = false
			idx += 1

func start_animate():
	get_node("CollisionShape2D").disabled = true
	idx = 0
	animate = true
