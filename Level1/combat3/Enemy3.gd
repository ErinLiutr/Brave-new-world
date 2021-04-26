extends KinematicBody2D

var velocity = Vector2(30, 0)
var life_points = 200
var pop_up
onready var animationPlayer = null
var incr = 0.001

func stop():
	set_physics_process(false)
	set_process(false)

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if (self.position.x > 500 or self.position.x < 0):
		self.velocity = Vector2(self.velocity.x*-1, self.velocity.y)
	self.velocity = Vector2(self.velocity.x+incr, self.velocity.y)
	if life_points <= 0:
		$"../Player".stop_player()
		set_physics_process(false)
		set_process(false)
		$"../../Win".visible = true
		$"../../Win".start()
