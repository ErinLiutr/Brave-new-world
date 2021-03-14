extends Node2D
const WIDTH = 48
const HEIGHT = 96
const MAX = 5
const SCALE = 40
const BULLET = preload("res://Scene/Bullet.tscn")

# spawn time management
var delta = 2#0.2
var offset = 2#0.2
var spawnArea = Rect2()

func _ready():
	randomize()
	spawnArea = Rect2(-180, 50, WIDTH, HEIGHT)
	next_spawn()
	
func spawn_bullet():
	var new_position = Vector2(-100+randi()%WIDTH, 300+randi()%HEIGHT) #-180+randi()%WIDTH,50+randi()%HEIGHT
#	var start = Vector2(100, 100)
	var direction = (new_position - get_parent().position).normalized()
	var num_bullets = randi()%MAX + 1
	var prev_position = [200, 150]
	for i in range(num_bullets):
		var bullet = BULLET.instance()
		get_parent().add_child(bullet)
		bullet.global_position = Vector2(prev_position[0]+direction.x*SCALE, prev_position[1] +direction.y*SCALE)
		prev_position = bullet.global_position
		bullet.set_bullet_direction(direction)

func next_spawn():
	var next_time = delta +(randf()-0.5)*2*offset
	$Timer.wait_time = next_time
	$Timer.start()
	
func start():
	set_physics_process(true)
	set_process(true)
	next_spawn()

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
