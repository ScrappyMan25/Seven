extends Node2D
class_name Connect
var area2d : Area2D
func _ready():
	
	pass # Replace with function body.

#func _connectAreaSignal() -> void:
#	var err
#	if area2d:
#		err = area2d.connect("area_entered", self, "_on_Connect_area_entered")
#	if err:
#		print(err)
#	pass

#func _on_Connect_area_entered(_area: Area2D) -> void:
#	if _area.name == "PlayerProjectile":
#		get_parent().call_deferred("addScore", 5)
#		queue_free()
#	pass
