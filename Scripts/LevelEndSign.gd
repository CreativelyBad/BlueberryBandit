extends Area2D


func _on_LevelEndSign_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://UI/Menu.tscn")
