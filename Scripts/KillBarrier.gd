extends Area2D


func _on_KillBarrier_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.respawn()
