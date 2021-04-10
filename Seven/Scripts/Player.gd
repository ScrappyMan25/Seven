extends KinematicBody2D

export var Speed = 400
var ACCELERATION = 2000
var screen_size
var velocity = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	pass
	
func _process(delta):
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	
	#Movement 2 and 3
	
#	get_input()
	
	#Movement 1
	
	var movement = get_input()
	if movement == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(movement * ACCELERATION * delta)
	
	#Apply movement
	velocity = move_and_slide(velocity)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	pass
#Movement 1
func apply_movement(acceleration):
	velocity += acceleration
	velocity = velocity.clamped(Speed)
	pass
	
func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO
	pass

func get_input():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()
	pass

#Movement 2
#func get_input():
#	velocity = Vector2.ZERO
#	if Input.is_action_pressed("ui_right"):
#		velocity += transform.x * Speed
#	if Input.is_action_pressed("ui_left"):
#		velocity -= transform.x * Speed
#	if Input.is_action_pressed("ui_down"):
#		velocity += transform.y * Speed
#	if Input.is_action_pressed("ui_up"):
#		velocity -= transform.y * Speed
#	velocity = velocity.normalized() * Speed
#	pass

#Movement 3
#func get_input():
#	velocity = Vector2.ZERO
#	if Input.is_action_pressed("ui_down"):
#		velocity += transform.y * Speed
#	if Input.is_action_pressed("ui_up"):
#		velocity -= transform.y * Speed
#	velocity = velocity.normalized() * Speed
#	pass
