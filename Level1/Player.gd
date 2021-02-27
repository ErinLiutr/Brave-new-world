extends KinematicBody2D

var direction = Vector2(0, 0)
var startPos = position
var moving = false

var canMove = true
var pressed = false

const SPEED = 1
const GRID = 16

var world
var sprite
var animationPlayer

var script_url = "res://items.json"
var json
var choice_item = preload("res://Choice.tscn")

func _ready():
	json = load_data(script_url)
	world = get_world_2d().get_direct_space_state()
	set_physics_process(true)
	sprite = get_node("Sprite")
	animationPlayer = get_node("AnimationPlayer")
	
func load_data(url):
	var file = File.new()
	if url == null: return null
	if !file.file_exists(url): return null
	file.open(url, File.READ)
	var data = {}
	data = parse_json(file.get_as_text())
	file.close()
	return data
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_interact") and canMove:
		pressed = true
	elif event.is_action_released("ui_interact"):
		pressed = false
		
func _physics_process(delta):
	if !moving and canMove:
		var resultUp = world.intersect_point(position + Vector2(0, -GRID))
		var resultDown = world.intersect_point(position + Vector2(0, GRID))
		var resultLeft = world.intersect_point(position + Vector2(-GRID, 0))
		var resultRight = world.intersect_point(position + Vector2(GRID, 0))
		
		
		if Input.is_action_pressed("ui_up"):
			sprite.set_frame(8)
			if resultUp.empty():
				moving = true
				direction = Vector2(0, -1)
				startPos = position
				animationPlayer.play("RunUp")
		elif Input.is_action_pressed("ui_down"):
			sprite.set_frame(0)
			if resultDown.empty():
				moving = true
				direction = Vector2(0, 1)
				startPos = position
				animationPlayer.play("RunDown")
		elif Input.is_action_pressed("ui_left"):
			sprite.set_frame(4)
			if resultLeft.empty():
				moving = true
				direction = Vector2(-1, 0)
				startPos = position
				animationPlayer.play("RunLeft")
		elif Input.is_action_pressed("ui_right"):
			sprite.set_frame(12)
			if resultRight.empty():
				moving = true
				direction = Vector2(1, 0)
				startPos = position
				animationPlayer.play("RunRight")
		
		if pressed:
			if sprite.get_frame() == 0:
				interact(resultDown)
			elif sprite.get_frame() == 4:
				interact(resultLeft)
			elif sprite.get_frame() == 8:
				interact(resultUp)
			elif sprite.get_frame() == 12:
				interact(resultRight)
	elif canMove:
		move_and_collide(direction * SPEED)
		var diff = position - (startPos + Vector2(GRID * direction.x, GRID * direction.y))

		if abs(diff.x) < 0.1 && abs(diff.y) < 0.1:
			moving = false
	pressed = false
			
func interact(result):
	for dictionary in result:
		if typeof(dictionary.collider) == TYPE_OBJECT and (dictionary.collider.has_node("Interact")):
			var name = dictionary.collider.get_node("Interact").type
			var node = get_node("/root/Room/YSort/Player/Camera2D/" + name)
			canMove = false
			node.show()
			if node.has_node("Game"):
				get_node("Camera2D/blur").show()
			if name == "Description":
				var id = dictionary.collider.get_node("Interact").id
				node.get_node("Choices/Description").text = json[str(id)]["description"]
				var idx = 0
				for choice in json[str(id)]["options"]:
					var new_choice = choice_item.instance()
					new_choice.name = choice
					if idx == 0:
						new_choice.get_node("selector").text = ">"
					else:
						new_choice.get_node("selector").text = ""
					idx += 1
					new_choice.get_node("choice").text = choice
					if choice == "game":
						new_choice.get_node("choice").text = "view"
						var game_name = json[str(id)]["game"]["name"]
						node.get_node("Choices").choice_results.append(game_name)
					else:
						node.get_node("Choices").choice_results.append(choice)
					node.get_node("Choices/GridContainer").add_child(new_choice)
				node.get_node("Choices").counter = 0
				node.get_node("Choices").current_selection = 0
				node.get_node("Choices").showing = true
				node.get_node("Choices").show()
				node.get_node(json[str(id)]["picture"]).show()
			if name == "DialogBox":
				node._start("01")
			else:
				node._start_show()
