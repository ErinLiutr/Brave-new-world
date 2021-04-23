extends Node2D


var sprite
var animationPlayer
var fadein = false
var fadeout = false


func _ready():
	set_physics_process(true)
	sprite = get_node("Sprite")
	animationPlayer = get_node("AnimationPlayer")
	
func _physics_process(delta):
	if fadein and !animationPlayer.is_playing():
		fadein = false
		get_parent().get_parent().get_parent().get_parent()._progress()
	elif fadeout and !animationPlayer.is_playing():
		fadeout = false
		hide()
		get_node("../Guide")._start_show()
		
func _play_fadein():
	show()
	fadein = true
	animationPlayer.play("fadein")

func _play_fadeout():
	show()
	fadeout = true
	animationPlayer.play("fadeout")
