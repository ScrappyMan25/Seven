extends KinematicBody2D

var velocity : float
var direction : Vector2 = Vector2.ZERO

var Game_Scene : Node
var UIScene : Node

var number_of_bounces = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = 490
	direction = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized()
	Game_Scene = get_parent()
	UIScene = Game_Scene.get_node("UI")
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var collision : KinematicCollision2D = move_and_collide(direction * velocity * delta)
	if number_of_bounces != -1:
		if collision:
			bounce(collision)
	else:
		get_parent().get_node("UI").get_tree().paused = true
		UIScene.get_node("Score").hide()
		UIScene.get_node("GameOver").show()
		print("GameOver")
	pass

func bounce(collision : KinematicCollision2D):
	direction = direction.bounce(collision.normal)
	if collision.collider is KinematicBody2D: #Player
		number_of_bounces = 7
		velocity = 490
	else:
		number_of_bounces -= 1
		velocity = velocity - 70
	print(number_of_bounces)
	pass


func _on_PlayerProjectile_tree_entered():
	
	pass # Replace with function body.
