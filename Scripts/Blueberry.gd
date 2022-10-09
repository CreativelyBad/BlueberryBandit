extends Area2D


func _on_Blueberry_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		queue_free()
		body.blueberry_collected()
