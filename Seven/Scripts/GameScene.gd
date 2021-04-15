extends Node

var Score : int = 0
var ScoreMultiplier : int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addScore(s : int):
	Score += s * ScoreMultiplier
	UpdateScore()
	pass

func UpdateScore() -> void:
	$UI.call_deferred("update_score", Score)
	pass

func _on_ScoreTimer_timeout():
	Score += ScoreMultiplier
	$ScoreTimer.start()
	UpdateScore()
	pass # Replace with function body.
