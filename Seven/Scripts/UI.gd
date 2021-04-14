extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseButtons.hide()
	pass # Replace with function body.


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
