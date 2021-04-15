extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseButtons.hide()
	update_score(0)
	pass # Replace with function body.

func update_score(score : int) -> void:
	#Change the text of score lable
	$Score.text = score as String
	pass

func _on_Pause_pressed():
	get_tree().paused = true
	$PauseButtons.show()
	pass # Replace with function body.


func _on_Continue_pressed():
	get_tree().paused = false
	$PauseButtons.hide()
	pass # Replace with function body.


func _on_Exit_pressed():
	var err = get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	if err:
		print(err)
	get_tree().paused = false
	pass # Replace with function body.

func _on_Restart_pressed():
	var err = get_tree().reload_current_scene()
	if err:
		print(err)
	get_tree().paused = false
	pass # Replace with function body.
