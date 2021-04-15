extends Node2D

var Enemy = preload("res://Scenes/Enemy_template.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_Enemy() -> void:
	var newEnemy = Enemy.instance()
	pass
