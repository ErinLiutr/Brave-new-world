extends Node2D

var showing = false

var pressed = false
var counter = 0

func _ready():
	set_physics_process(true)
	set_process_unhandled_key_input(true)
	
func _unhandled_key_input(event):
	if event.is_action_pressed("ui_interact"):
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false
		
func _physics_process(delta):
	if showing:
		counter += 1
		if pressed and counter > 10:
			counter = 0
			_stop_show()
			get_node("/root/Room/YSort/Player").canMove = true
	pressed = false

func _start_show():
	showing = true
	get_node("YSort/player").global_position = Vector2(160, 64)
	get_node("YSort/Enemy/BulletSpawner").start()
	get_node("../blur").show()
	get_node("Walls/Down").disabled = false
	get_node("Walls/Left").disabled = false
	get_node("Walls/Up").disabled = false
	get_node("Walls/Right").disabled = false
	get_node("YSort/Enemy/CollisionShape2D").disabled = false
	get_node("YSort/Enemy/Area2D/CollisionShape2D2").disabled = false
	get_node("YSort/player/CollisionShape").disabled =false
	get_node("YSort/player/Area2D/CollisionShape2D").disabled = false
	get_node("/root/Room/YSort/NPC/CollisionShape2D").disabled = true
	get_node("/root/Room/YSort/Player/CollisionShape2D").disabled = true
	get_node("/root/Room/YSort/Obstacle/Left").disabled = true
	get_node("/root/Room/YSort/Obstacle/Right").disabled = true
	get_node("/root/Room/YSort/Obstacle/Up").disabled = true
	get_node("/root/Room/YSort/Obstacle/Down").disabled = true
	get_node("/root/Room/YSort/bed/CollisionShape2D").disabled = true
	get_node("/root/Room/YSort/cabinet1/CollisionShape2D").disabled = true
	get_node("/root/Room/YSort/table/CollisionShape2D").disabled = true
	get_node("/root/Room/YSort/shirt/CollisionShape2D").disabled = true
	get_node("/root/Room/pad/CollisionShape2D").disabled = true
	get_node("/root/Room/bottle/CollisionShape2D").disabled = true
	get_node("/root/Room/cabinet2/StaticBody2D/CollisionShape2D").disabled = true
	
func _stop_show():
	hide()
	get_node("Popup/PopupMenu").hide()
	showing = false
	get_node("YSort/Enemy/BulletSpawner").stop()
	get_node("../blur").hide()
	get_node("Walls/Down").disabled = true
	get_node("Walls/Left").disabled = true
	get_node("Walls/Up").disabled = true
	get_node("Walls/Right").disabled = true
	get_node("YSort/Enemy/CollisionShape2D").disabled = true
	get_node("YSort/Enemy/Area2D/CollisionShape2D2").disabled = true
	get_node("YSort/player/CollisionShape").disabled = true
	get_node("YSort/player/Area2D/CollisionShape2D").disabled = true
	get_node("/root/Room/YSort/NPC/CollisionShape2D").disabled = false
	get_node("/root/Room/YSort/Player/CollisionShape2D").disabled = false
	get_node("/root/Room/YSort/Obstacle/Left").disabled = false
	get_node("/root/Room/YSort/Obstacle/Right").disabled = false
	get_node("/root/Room/YSort/Obstacle/Up").disabled = false
	get_node("/root/Room/YSort/Obstacle/Down").disabled = false
	get_node("/root/Room/YSort/bed/CollisionShape2D").disabled = false
	get_node("/root/Room/YSort/cabinet1/CollisionShape2D").disabled = false
	get_node("/root/Room/YSort/table/CollisionShape2D").disabled = false
	get_node("/root/Room/YSort/shirt/CollisionShape2D").disabled = false
	get_node("/root/Room/pad/CollisionShape2D").disabled = false
	get_node("/root/Room/bottle/CollisionShape2D").disabled = false
	get_node("/root/Room/cabinet2/StaticBody2D/CollisionShape2D").disabled = false
