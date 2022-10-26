extends CanvasLayer


onready var globals = get_node("/root/Globals")

func _ready() -> void:
	$Main/VBoxContainer/DistanceText.text = str(globals.global_distance)
	$Main/VBoxContainer/BlueBerriesText.text = str(globals.global_blueberries)
	set_high_scores()

func _on_Menu_Button_pressed() -> void:
	get_tree().change_scene("res://UI/Menu.tscn")

func set_high_scores():
	if globals.global_distance > globals.global_high_score_distance:
		globals.global_high_score_distance = globals.global_distance
	
	if globals.global_blueberries > globals.global_high_score_blueberries:
		globals.global_high_score_blueberries = globals.global_blueberries
