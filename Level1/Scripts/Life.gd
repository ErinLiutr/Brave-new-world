extends Node

#signal max_changed(new_max)
signal changed(new_amount)
signal depleted

const MAX = 200
onready var current = MAX setget set_current

func _physics_process(delta):
	set_current(get_parent().life_points)
	
func set_current(new_life):
	current = new_life
	current = clamp(current, 0, MAX)
	emit_signal("changed", current)
	if current == 0:
		emit_signal("depleted")

func _on_EnemyLife_changed(new_amount):
	pass # Replace with function body.
