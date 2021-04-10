extends KinematicBody2D

export var Speed = 400
var ACCELERATION = 2000
var screen_size
var velocity = Vector2.ZERO

#Dash
export(PackedScene) var dash_object
export var dash_speed = 1000
export var dash_length = 0.2
var is_dashing : bool = false
var can_dash : bool = true
var dash_direction : Vector2
onready var dash_timer = $dash_timer
onready var dash_particles = $dash_particles

func _ready():
	dash_timer.connect("timeout",self,"dash_timer_timeout")
	screen_size = get_viewport_rect().size
	pass
	
func dash_timer_timeout():
	is_dashing = false
	pass
	
func get_direction_from_input():
	var move_dir = Vector2()
	#gets the direction of keyboard input
#	move_dir.x = -Input.get_action_strength("ui_left") + Input.get_action_strength("ui_right")
#	move_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_dir = get_global_mouse_position() - position
	move_dir = move_dir.clamped(1)
	
	#dash toward the direction you're facing
#	if move_dir == Vector2(0,0):
#		move_dir.y = -1
#	else:
#		move_dir.y = 1
	return move_dir * dash_speed
	
func handle_dash(var delta):
	#check if we can dash
	if Input.is_action_just_pressed("dash") and can_dash:
		is_dashing = true
		can_dash = false
		dash_direction = get_direction_from_input()
		dash_timer.start(dash_length)
		pass
	if is_dashing: #Can add dash textures
		var dash_node = dash_object.instance()
#		dash_node.texture = (animation.frames.get_frame(animation.animation, animation.frame)
		dash_node.global_position = global_position
		get_parent().add_child(dash_node)
		#Particles on
		dash_particles.emitting = true
		if is_on_wall():
			is_dashing = false
		pass
	else:
		dash_particles.emitting = false
		can_dash = true
	pass
	
func _process(delta):
	handle_dash(delta)
	
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	
	#Movement 2 and 3
	get_input()

	#Movement 1
#	var movement = get_input()
#	if movement == Vector2.ZERO:
#		apply_friction(ACCELERATION * delta)
#	else:
#		apply_movement(movement * ACCELERATION * delta)
	
	#Apply movement
	if is_dashing:
		velocity = move_and_slide(dash_direction)
	else:
		velocity = move_and_slide(velocity)
		
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	pass
#Movement 1
#func apply_movement(acceleration):
#	velocity += acceleration
#	velocity = velocity.clamped(Speed)
#	pass
#
#func apply_friction(amount):
#	if velocity.length() > amount:
#		velocity -= velocity.normalized() * amount
#	else:
#		velocity = Vector2.ZERO
#	pass
#
#func get_input():
#	var axis = Vector2.ZERO
#	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
#	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
#	return axis.normalized()
#	pass

#Movement 2
func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity += transform.x * Speed
	if Input.is_action_pressed("ui_left"):
		velocity -= transform.x * Speed
	if Input.is_action_pressed("ui_down"):
		velocity += transform.y * Speed
	if Input.is_action_pressed("ui_up"):
		velocity -= transform.y * Speed
	velocity = velocity.normalized() * Speed
	pass

#Movement 3
#func get_input():
#	velocity = Vector2.ZERO
#	if Input.is_action_pressed("ui_down"):
#		velocity += transform.y * Speed
#	if Input.is_action_pressed("ui_up"):
#		velocity -= transform.y * Speed
#	velocity = velocity.normalized() * Speed
#	pass
