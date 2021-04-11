extends KinematicBody2D

# Basee Player Stats
var Speed = 400
var screen_size
var velocity = Vector2.ZERO

#Dash
export(PackedScene) var dash_object #This is only for if you want to add like a dashing effect
export var dash_speed = 1000
export var dash_length = 0.2
var is_dashing : bool = false
var can_dash : bool = true
var dash_direction : Vector2
onready var dash_timer = $dash_timer
onready var dash_particles = $dash_particles

#When Object enters scene tree
func _ready():
	pass

#Repeats
func _physics_process(_delta):
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	get_input()
	handle_dash()
	if is_dashing:
		velocity = move_and_slide(dash_direction)
	else:
		velocity = move_and_slide(velocity)
	pass

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

func handle_dash():
	#check dash - Press Space to dash
	if Input.is_action_just_pressed("ui_select") and can_dash:
		is_dashing = true
		can_dash = false
		dash_direction = get_direction_from_input()
		dash_timer.start(dash_length)
		pass
	if is_dashing: #Can add dash textures
		var dash_node = dash_object.instance()
#		dash_node.texture = (animation.frames.get_frame(animation.animation, animation.frame) <- to add textures for more effect
		dash_node.global_position = global_position
		get_parent().add_child(dash_node)
		#turn particles on (currently using default particle)
		dash_particles.emitting = true
		if is_on_wall():
			is_dashing = false
		pass
	else:
		dash_particles.emitting = false
		can_dash = true
	pass

#gets the direction and dashes
func get_direction_from_input() -> Vector2:
	var move_dir = Vector2()
	#gets the direction of the mouse
	move_dir = get_global_mouse_position() - position
	move_dir = move_dir.clamped(1)
	return move_dir * dash_speed

#Signals
func _on_dash_timer_timeout() -> void:
	is_dashing = false
	pass # Replace with function body.
