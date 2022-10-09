extends KinematicBody2D

const SPEED = 500
const LIFESPAN = 1

var velocity = Vector2()
var spawn_time

func destroy():
	queue_free()

func _physics_process(delta: float) -> void:
	if OS.get_unix_time() - spawn_time > LIFESPAN:
		destroy()
	var collide = move_and_collide(velocity.normalized() * SPEED * delta)
	if collide:
		destroy()
		collide.collider.emit_signal("hit")

func _ready() -> void:
	spawn_time = OS.get_unix_time()
