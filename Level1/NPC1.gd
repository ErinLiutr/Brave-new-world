extends StaticBody2D


var animationPlayer
var animate = false

func _ready():
	set_physics_process(true)
	animationPlayer = get_node("AnimationPlayer")

func _physics_process(delta):
	
	if animate and !animationPlayer.is_playing():
		print("stop")
		animate = false
		get_node("Sprite").hide()
		get_node("Skeleton").show()
		get_parent().get_parent().get_node("Player/Camera2D/DialogBox").show()
		get_parent().get_parent().get_node("Player/Camera2D/DialogBox")._start("16")

func start_animate():
	print("play")
	show()
	animationPlayer.play("animation")
	animate = true
