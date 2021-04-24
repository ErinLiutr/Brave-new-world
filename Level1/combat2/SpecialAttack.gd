extends KinematicBody2D

var points

func _ready():
	points = randi() % (20 - 5) + 5
	self.scale = Vector2(0.5+(points/5), 0.5+(points/5))
	$Timer.wait_time = 3-0.1*points
	$Timer.start()
	
func _on_Timer_timeout():
	call_deferred("free")
	
func _physics_process(delta):
	var collision = move_and_collide(Vector2.ZERO)
	if collision:
		if collision.collider.name == "Player":
			collision.collider.add_points(points)
			call_deferred("free")
