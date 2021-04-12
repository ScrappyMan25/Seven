extends KinematicBody2D

var velocity : float
var direction : Vector2 = Vector2.ZERO

var number_of_bounces = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set velocity to something 
	velocity = 490
	#set direction to something
	direction = get_global_mouse_position() - position
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	#move with velocity in direction
	move_and_slide(direction.normalized() * velocity)
	#onCollision -> 
	if is_on_wall():
		var collision = move_and_collide(direction * delta)
		#print bounce number
		print(number_of_bounces)
		#reverse direction
		direction = direction.bounce(collision.normal)
		move_and_slide(direction.normalized() * velocity)
		#reduce bounces
		number_of_bounces -= 1
		#reduce velocity
		velocity = velocity - 70
	pass
