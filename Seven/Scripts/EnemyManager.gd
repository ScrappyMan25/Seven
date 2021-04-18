extends Node2D

var Enemy = preload("res://Scenes/Enemy_template.tscn")
var rand = RandomNumberGenerator.new()

func _ready():
	spawn_Enemy()
pass

func spawn_Enemy() -> void:
	var newEnemy = Enemy.instance()
	rand.randomize()
	var x = rand.randf_range(64, 960)
	rand.randomize()
	var y = rand.randf_range(64, 536)
	newEnemy.position.y = y
	newEnemy.position.x = x
	add_child(newEnemy)
	pass

func _on_Enemy_spawn_timer_timeout():
	spawn_Enemy()
	$Enemy_spawn_timer.start()
	pass
