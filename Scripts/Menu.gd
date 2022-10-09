extends CanvasLayer


func _on_PlayButton_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Levels/Game.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit(0)
