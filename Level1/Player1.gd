extends Node2D

var animate = false
var dialog_id = ""

const SPEED = 1
const GRID = 16

var sprite
var animationPlayer
var equipment = ""

var script_url = "res://items.json"
var json
var choice_item = preload("res://Choice.tscn")

func _ready():
	set_physics_process(true)
	sprite = get_node("Player")
	animationPlayer = get_node("AnimationPlayer")

func _physics_process(delta):
	if animate and !animationPlayer.is_playing():
		animate = false
		get_node("Camera2D/DialogBox").show()
		get_node("Camera2D/DialogBox")._start(dialog_id)
		
func _start_play(id):
	dialog_id = id
	animationPlayer.play("wakeup")
	animate = true
