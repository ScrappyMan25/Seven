extends KinematicBody2D

var velocity : float
var direction : Vector2 = Vector2.ZERO

var number_of_bounces = 7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set velocity to something 
	#set direction to something
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	#move with velocity in direction
	
	#onCollision -> 
	#print bounce number
	#reverse direction
	#reduce bounces
	#reduce velocity
	pass
