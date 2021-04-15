extends KinematicBody2D

var velocity : float
var direction : Vector2 = Vector2.ZERO

var number_of_bounces = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = 490
	direction = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized()
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var collision : KinematicCollision2D = move_and_collide(direction * velocity * delta)
	if number_of_bounces != -1:
		if collision:
			bounce(collision)
	else:
		get_parent().get_node("UI").get_tree().paused = true
		print("GameOver")
	pass

func bounce(collision : KinematicCollision2D):
	direction = direction.bounce(collision.normal)
	print(number_of_bounces)
	number_of_bounces -= 1
	velocity = velocity - 70
	pass
