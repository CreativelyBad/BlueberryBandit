extends CanvasLayer

onready var main_screen = get_node("Main")
onready var level_screen = get_node("Levels")

func _on_PlayButton_pressed() -> void:
	main_screen.visible = false
	level_screen.visible = true


func _on_QuitButton_pressed() -> void:
	get_tree().quit(0)


func _on_Lvl1Btn_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_Lvl2Btn_pressed() -> void:
	pass # Replace with function body.


func _on_Lvl3Btn_pressed() -> void:
	pass # Replace with function body.


func _on_Lvl4Btn_pressed() -> void:
	pass # Replace with function body.


func _on_Lvl5Btn_pressed() -> void:
	pass # Replace with function body.


func _on_Lvl6Btn_pressed() -> void:
	pass # Replace with function body.


func _on_BackButton_pressed() -> void:
	main_screen.visible = true
	level_screen.visible = false
