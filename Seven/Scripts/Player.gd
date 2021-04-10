extends Area2D

export var Speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	pass
	
func _process(delta):
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	var direction = get_global_mouse_position() - position
	var normalized_direction = direction.normalized()
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		rotation_degrees -= 90
		velocity = velocity * Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		rotation_degrees += 90
	if Input.is_action_pressed("ui_down"):
		velocity = -Vector2(normalized_direction)
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(normalized_direction)
	if velocity.length() > 0:
		velocity = velocity.normalized() * Speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	pass
