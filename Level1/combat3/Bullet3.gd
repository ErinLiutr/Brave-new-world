"""
These are bullets shot by the enemy npc in the level. Bullets will be shot
at random direction from the enemy npc and will disappear after leaving
the boundaries of the scene. If the player got hit by a bullet, he loses 
one life point. 
"""

extends KinematicBody2D

const SPEED = 60
var velocity = Vector2()

func _physics_process(delta):
	$Sprite.rotation += 75
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.collider.name == "Player":
			print("hi bullet")
			collision.collider.add_point()#lose_life()
		if collision.collider.name != "Ball":
			call_deferred("free")
		
func set_bullet_direction(direction):
	velocity = direction * SPEED
	
func stop():
	set_physics_process(false)
	set_process(false)
	call_deferred("free")
