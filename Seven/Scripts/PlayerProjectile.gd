extends KinematicBody2D

var velocity : float
var direction : Vector2 = Vector2.ZERO

var Game_Scene : Node
var UIScene : Node
var SoundScene : Node

var number_of_bounces = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = 490
	direction = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized()
	Game_Scene = get_parent()
	UIScene = Game_Scene.get_node("UI")
	SoundScene = Game_Scene.get_node("SoundScene")
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	UIScene.call_deferred("update_bounce", number_of_bounces)
	var collision : KinematicCollision2D = move_and_collide(direction * velocity * delta)
	if number_of_bounces != 0:
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
	SoundScene.get_node("Ricochet").play()
	if collision.collider is KinematicBody2D: #Player
		number_of_bounces = 7
		get_node("7/Animation7").play("7")
		velocity = 490
	else:
		number_of_bounces -= 1
		if number_of_bounces == 1:
			get_node("1/Animation1").play("1")
		if number_of_bounces == 2:
			get_node("2/Animation2").play("2")
		if number_of_bounces == 3:
			get_node("3/Animation3").play("3")
		if number_of_bounces == 4:
			get_node("4/Animation4").play("4")
		if number_of_bounces == 5:
			get_node("5/Animation5").play("5")
		if number_of_bounces == 6:
			get_node("6/Animation6").play("6")
		velocity = velocity - 70
	pass

func _on_Area2D_body_entered(body):
	if "Enemy_template" in body.name:
		SoundScene.get_node("DestroyEnemy").play()
		get_parent().addScore(100)
		body.queue_free()
	pass # Replace with function body.
