extends Node2D
const WIDTH = 440
const HEIGHT = 750
const MAX = 5
const SCALE = 100
const BULLET = preload("res://combat2/Bullet.tscn")
const LIFE = preload("res://combat2/ExtraLife.tscn")
# spawn time management
var delta = 0.4
var offset = 0.5
var spawnArea = Rect2()


func _physics_process(d):
	delta -= 0.00005
	offset -= 0.00002
	
func _ready():
	randomize()
	spawnArea = Rect2(global_position.x-150, global_position.y-50, WIDTH, HEIGHT)
	next_spawn()
	
func spawn_bullet():
	var parent = Vector2(global_position.x-100, global_position.y-50)
	var new_position = Vector2(global_position.x-100, global_position.y)
	var direction = (new_position-parent).normalized()
	var num_bullets = 1#randi()%MAX + 1
	var prev_position = [global_position.x-100, global_position.y-50]
	for i in range(num_bullets):
		var bullet = BULLET.instance()
		bullet.global_position = Vector2(prev_position[0]+direction.x*SCALE, prev_position[1] +direction.y*SCALE)
		get_parent().add_child(bullet)
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
#
func _on_Timer_timeout():
	spawn_bullet()
	next_spawn()
	
