extends Area2D


func _on_Dummy_body_entered(body: Node) -> void:
	if body.is_in_group("bullet"):
		body.destroy()
		queue_free()
