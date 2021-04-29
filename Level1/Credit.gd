extends Node2D


var sprite
var animationPlayer
var animate = false


func _ready():
	set_physics_process(true)
	sprite = get_node("Sprite")
	animationPlayer = get_node("AnimationPlayer")
	
func _physics_process(delta):
	if animate and !animationPlayer.is_playing():
		animate = false
		get_parent()._return()
		
func _play():
	show()
	animate = true
	animationPlayer.play("Anim")

