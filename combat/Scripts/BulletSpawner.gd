extends Node2D
const WIDTH = 870
const HEIGHT = 500
const BULLET = preload("res://Scene/Bullet.tscn")

# spawn time management
var delta = 0.0005
var offset = 0.1
var spawnArea = Rect2()

func _ready():
	randomize()
	spawnArea = Rect2(-450, 5, WIDTH, HEIGHT)
	next_spawn()
	
func spawn_bullet():
	var new_position = Vector2(100+randi()%WIDTH,200+randi()%HEIGHT)
	var direction = (new_position - get_parent().position).normalized()
	var bullet = BULLET.instance()
	get_parent().add_child(bullet)
	bullet.global_position = get_parent().position
	bullet.set_bullet_direction(direction)

func next_spawn():
	var next_time = delta +(randf()-0.5)*2*offset
	$Timer.wait_time = next_time
	$Timer.start()

func stop():
	set_physics_process(false)
	set_process(false)
	for c in get_children():
		if (c.name == "Timer"):
			c.stop()

#func _draw():
#	draw_rect(spawnArea, Color(0.2, 0.2, 1.0, 0.5))

func _on_Timer_timeout():
	spawn_bullet()
	next_spawn()
