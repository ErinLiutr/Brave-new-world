extends Node2D
var WIDTH = 125
var HEIGHT = 40
var spawnArea
const LIFE = preload("res://combat3/SpecialAttack.tscn")

func stop():
	set_physics_process(false)
	set_process(false)
	$Timer.stop()
	
func _ready():
	$Timer.start()

func random_lives():
	var new_position = Vector2(global_position.x-25+ randi()%WIDTH,
							global_position.y+65+randi()%HEIGHT)
	var life = LIFE.instance()
	get_parent().add_child(life)
	life.visible = true
	life.global_position = new_position

func _on_Timer_timeout():
	random_lives()
	$Timer.start()
