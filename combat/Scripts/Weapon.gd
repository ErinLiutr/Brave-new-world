extends Area2D
const kill_point = 5


func _ready():
	$Timer.wait_time = $ProgressBar.value
	$Timer.start()
	
func _physics_process(delta):
	$ProgressBar.value = $Timer.time_left
#	print($ProgressBar.value)
#	if 	$ProgressBar.value == 0.0:
#		$CanvasModulate.visible = false
#		$Timer.stop()
		
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
#				$CanvasModulate.visible = true
				for i in range(kill_point):
					$"../../YSort/Enemy".lose_life()

