extends KinematicBody2D

# warning-ignore:unused_signal
signal hit

const BULLET = preload("res://Objects/EnemyBullet.tscn")
const SPEED = 20
const GRAVITY = 5

var velocity = Vector2(1,0)
var current_dir

func shoot():
	var new_bullet = BULLET.instance()
	get_parent().add_child(new_bullet)
	new_bullet.position = $Sprite/Barrel.global_position
	new_bullet.velocity = Vector2(velocity.x, 0)

func _ready() -> void:
	velocity.x = -SPEED
	current_dir = velocity.x
	$AnimationPlayer.play("Walk")
	
# warning-ignore:return_value_discarded
	$Timer.connect("timeout", self, "shoot")
	$Timer.start(1)

func _physics_process(_delta: float) -> void:
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity)
	
	if velocity.x == 0:
		current_dir = current_dir * -1
		velocity.x = current_dir
		$Sprite.scale.x = $Sprite.scale.x * -1

func _on_Enemy_hit() -> void:
	queue_free()

