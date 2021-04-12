extends KinematicBody2D

#Variable to declare the type of User Device - Dynamic
const KEYBOARD = 0
const CONTROLLER = 1
const MOBILE = 1
var InputDevice

#Variables required for movement
var speed : float = 400
var velocity : Vector2 = Vector2.ZERO

#for COntroller
var rotation_dir = 0
var rotation_speed = 5

#for Dash
var can_dash : bool = true
var is_dashing : bool = false
var dash_speed = 2000
var dash_length = 0.2
var dash_direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	get_input()
	if is_dashing:
		velocity = move_and_slide(dash_direction)
#		is_dashing = false
	else:
		velocity = move_and_slide(velocity)
	pass
	if InputDevice == CONTROLLER:
		rotation += rotation_dir * rotation_speed * _delta

func get_input() -> void:
	match(InputDevice):
		KEYBOARD:
			look_at(get_global_mouse_position())
			velocity = Vector2()
			if Input.is_action_pressed("ui_down"):
				velocity = Vector2(-speed, 0).rotated(rotation)
			if Input.is_action_pressed("ui_up"):
				velocity = Vector2(speed, 0).rotated(rotation)
			pass
		CONTROLLER:
			rotation_dir = 0
			velocity = Vector2()
			if Input.is_action_pressed("point_right"):
				rotation_dir += 1
			if Input.is_action_pressed("point_left"):
				rotation_dir -= 1
			if Input.is_action_pressed("ui_down"):
				velocity = Vector2(-speed, 0).rotated(rotation)
			if Input.is_action_pressed("ui_up"):
				velocity = Vector2(speed, 0).rotated(rotation)
			pass
		MOBILE:
			pass
	#Dash Code
	if Input.is_action_just_pressed("ui_select") and !is_dashing:#can_dash:
		is_dashing = true
#		can_dash = false
		$DashTimer.start(dash_length)
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
