extends KinematicBody2D

#Variable to declare the type of User Device - Dynamic
const KEYBOARD = 0
const CONTROLLER = 1
const MOBILE = 1
var InputDevice

#Getting Sound Scene
var Game_Scene : Node
var SoundScene : Node
var EndGame : Node

#Variables required for movement
var speed : float = 400
var velocity : Vector2 = Vector2.ZERO
var friction = 0.0001
var acceleration = 0.001

#for COntroller
var rotation_dir = 0
var rotation_speed = 5

#for Dash
var num_dash = 1
var can_dash : bool = true
var is_dashing : bool = false
var dash_speed = 2000
var dash_length = 0.2
var dash_direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game_Scene = get_parent()
	SoundScene = Game_Scene.get_node("SoundScene")
	EndGame = Game_Scene.get_node("UI")
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	get_input()
#	var axis = get_input()
#	if axis == Vector2.ZERO:
#		apply_friction(acceleration * _delta)
#	else:
#		apply_acceleration(acceleration * _delta * axis)
#	if direction.length() > 0:
#		velocity = lerp(velocity,direction.normalized()*speed,acceleration)
#	else:
#		velocity = lerp(velocity, Vector2.ZERO, friction)
	if is_dashing:
		velocity = move_and_slide(dash_direction)
#		is_dashing = false
	else:
		velocity = move_and_slide(velocity)
	pass
	if InputDevice == CONTROLLER:
		rotation += rotation_dir * rotation_speed * _delta

#func apply_acceleration(acceleration):
#	velocity += acceleration
#	velocity = velocity.clamped(speed)
#	pass
#
#func apply_friction(amount):
#	if velocity.length() > amount:
#		velocity -= velocity.normalized() * amount
#	else:
#		velocity = Vector2.ZERO
#	pass

func get_input() -> void: 
#	var input = Vector2()
	match(InputDevice):
		KEYBOARD:
			look_at(get_global_mouse_position())
			velocity = Vector2()
#			if Input.is_action_pressed("ui_down"):
#				velocity = Vector2(-speed, 0).rotated(rotation)
#				input.y += 1
#			if Input.is_action_pressed("ui_up"):
#				input.y -= 1
#				velocity = Vector2(speed, 0).rotated(rotation)
#			if velocity != Vector2.ZERO:
#				velocity = lerp(velocity, velocity * speed, acceleration)
#				pass
#			else:
#				velocity = lerp(velocity,Vector2.ZERO,friction)
#				pass
#			return input
			pass
		CONTROLLER:
			rotation_dir = 0
			velocity = Vector2()
			if Input.is_action_pressed("point_right"):
				rotation_dir += 1
#				input.x += 1
			if Input.is_action_pressed("point_left"):
				rotation_dir -= 1
#				input.x -= 1
			if Input.is_action_pressed("ui_down"):
				velocity = Vector2(-speed, 0).rotated(rotation)
#				input.y += 1
			if Input.is_action_pressed("ui_up"):
				velocity = Vector2(speed, 0).rotated(rotation)
#				input.y -= 1
			pass
		MOBILE:
			pass
#	return input
	#Dash Code
	if Input.is_action_just_pressed("ui_select") and !is_dashing:#can_dash:
		is_dashing = true
		num_dash -= 1
#		can_dash = false
		$DashTimer.start(dash_length)
		SoundScene.get_node("Dash").play()
#		dash_direction = velocity.clamped(1) * dash_speed
		if Input.is_action_pressed("ui_down"):
			dash_direction = Vector2.RIGHT.rotated(rotation + 135) * dash_speed
		else:
			dash_direction = Vector2.RIGHT.rotated(rotation) * dash_speed
		
		$DashParticles.emitting = true
	else:
#		can_dash = true
		$DashParticles.emitting = false
		pass
	pass

func _input(event):
	if(event is InputEventKey or event is InputEventMouseMotion):
		InputDevice = KEYBOARD
		pass
	elif(event is InputEventJoypadButton || event is InputEventJoypadMotion):
		InputDevice = CONTROLLER
		pass
	elif(event is InputEventScreenTouch):
		InputDevice = MOBILE
		pass
pass

#Signals

func _on_DashTimer_timeout() -> void:
	is_dashing = false
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print(body.name)
	if "Enemy_template" in body.name:
		get_parent().get_node("UI").get_tree().paused = true
		EndGame.get_node("Score").hide()
		EndGame.get_node("GameOver").show()
	if body.name == "PlayerProjectile":
		num_dash += 1
	pass # Replace with function body.
