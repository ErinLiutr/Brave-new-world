extends KinematicBody2D

func _ready():
	$Timer.start()
	
func _on_Timer_timeout():
	call_deferred("free")

func _physics_process(delta):
	var collision = move_and_collide(Vector2.ZERO)
	if collision:
		if collision.collider.name == "Player":
			collision.collider.add_life()
			call_deferred("free")
