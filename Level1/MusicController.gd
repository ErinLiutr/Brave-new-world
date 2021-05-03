extends Node2D


var ambience_music = preload("res://music/ambience_prologue.wav")
var battle_music = preload("res://music/battle-draft.wav")
var chapter1_music = preload("res://music/chapter1-theme.wav")
var chapter2_music = preload("res://music/ch2_main_scene.wav")
var title_music = preload("res://music/theme1-v3slow.wav")
var epilogue_music = preload("res://music/epilogue.wav")
var battle2_music = preload("res://music/battle-ch2.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_ambience():
	$AudioStreamPlayer.stream = ambience_music
	$AudioStreamPlayer.play()
	
func play_battle():
	$AudioStreamPlayer.stream = battle_music
	$AudioStreamPlayer.play()
	
func play_battle2():
	$AudioStreamPlayer.stream = battle2_music
	$AudioStreamPlayer.play()
	
func play_ending():
	$AudioStreamPlayer.stream = epilogue_music
	$AudioStreamPlayer.play()

func play_chapter1():
	$AudioStreamPlayer.stream = chapter1_music
	$AudioStreamPlayer.play()

func play_chapter2():
	$AudioStreamPlayer.stream = chapter2_music
	$AudioStreamPlayer.play()
	
func play_title():
	$AudioStreamPlayer.stream = title_music
	$AudioStreamPlayer.play()
