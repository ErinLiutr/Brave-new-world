"""
These are balls shot by the player. Balls will move in the direction 
where the mouse clicks on the screen. They'll disappear after leaving
the boundaries of the scene
"""
extends KinematicBody2D

const SPEED = 80
var velocity = Vector2()
#var destroyed = false

func _physics_process(delta):
	$Sprite.rotation += 75
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.collider.name == "Enemy":
			collision.collider.lose_life(true)
		call_deferred("free")
		
func set_bullet_direction(direction):
	velocity = direction * SPEED
#
func stop():
	set_physics_process(false)
	set_process(false)
	call_deferred("free")
