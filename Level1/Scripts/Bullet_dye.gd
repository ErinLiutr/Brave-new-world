"""
These are bullets shot by the enemy npc in the level. Bullets will be shot
at random direction from the enemy npc and will disappear after leaving
the boundaries of the scene. If the player got hit by a bullet, he loses 
one life point. 
"""

extends KinematicBody2D

const SPEED = 500
const KILL = 20
var velocity = Vector2()

func _physics_process(delta):
	$Sprite.rotation += 75
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.collider.name == "Enemy":
			for i in range(KILL):
				collision.collider.lose_life(false)
			collision.collider.lose_20()
		call_deferred("free")
		
func set_bullet_direction(direction):
	velocity = direction * SPEED
	
func stop():
	set_physics_process(false)
	set_process(false)
	call_deferred("free")
