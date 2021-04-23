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
		get_parent().get_node("YSort/Player").canMove = true

		
func _open():
	animate = true
	animationPlayer.play("open")
