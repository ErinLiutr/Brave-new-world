extends Node2D
var started = false

func _ready():
	$Timer.start()
	
func _input(event):
	if event is InputEventKey and event.scancode == KEY_C:
		$"YSort/Enemy".life_points = 0

func _on_Timer_timeout():
	if $"YSort/Enemy".life_points > 0:
		$"YSort/Player".stop_player()
		$"YSort/Enemy".stop()
		$"YSort/Enemy/BulletSpawner".stop()
		$"ExtraPoints".stop()
		$"ExtraLives".stop()
		$"Lose".visible = true
		$"Lose".start()
