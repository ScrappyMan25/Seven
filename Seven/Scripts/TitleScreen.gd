extends Control

var scene_to_load : PackedScene
var GameScene : PackedScene = preload("res://Scenes/test.tscn")
func _ready():
	pass # Replace with function body.

func _on_FadeIn_fade_finished():
	queue_free()
	var err = get_tree().change_scene_to(scene_to_load)
	if err:
		print(err)
	pass # Replace with function body.


func _on_Play_pressed():
	scene_to_load = GameScene
	$FadeIn.show()
	$FadeIn.fade_in()
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
