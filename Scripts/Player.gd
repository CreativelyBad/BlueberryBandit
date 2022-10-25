extends KinematicBody2D

# warning-ignore:unused_signal
signal shot

const BULLET = preload("res://Objects/Bullet.tscn")
const SPEED = 100
const MAX_FALL_SPEED = 500
const GRAVITY = 8
const JUMP = 200
const AIM_LIMIT = 45
const MAX_HEALTH = 3

var start_pos
var velocity = Vector2()
var jumps = 0
var blueberries = 0
var health
var hearts = []

func get_input():
	# ======== MANUAL MOVEMENT CODE ========
#	if Input.is_action_pressed("left"):
#		velocity.x = -SPEED
#		$Character.scale.x = sign(velocity.x)
#		if is_on_floor():
#			$AnimationPlayer.play("Run")
#	elif Input.is_action_pressed("right"):
#		velocity.x = SPEED
#		$Character.scale.x = sign(velocity.x)
#		if is_on_floor():
#			$AnimationPlayer.play("Run")
#	else:
#		velocity.x = lerp(velocity.x, 0, 0.2)
#		if is_on_floor():
#			$AnimationPlayer.play("Idle")
	
	if Input.is_action_just_pressed("jump"):
		jump()
	
	if Input.is_action_just_pressed("Shoot"):
		shoot()

func check_grounded():
	if is_on_floor():
		jumps = 0
		$AnimationPlayer.play("Run")

func blueberry_collected():
	blueberries += 1
	$Camera2D/HUD/Control/BlueberryCounter.text = str(blueberries)

func respawn():
	position = start_pos

func shoot():
	var new_bullet = BULLET.instance()
	get_parent().add_child(new_bullet)
	new_bullet.position = $Character/Hand/Gun/Barrel.global_position
	new_bullet.rotation = $Character/Hand.global_rotation
	new_bullet.velocity = get_global_mouse_position() - new_bullet.position

func aim():
	$Character/Hand.look_at(get_global_mouse_position())

func _physics_process(_delta: float) -> void:
	
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
	
	check_grounded()
	get_input()
	aim()
	distance_counter()
	
	velocity.x = SPEED
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if velocity == Vector2.ZERO:
		$AnimationPlayer.play("Idle")

func _ready() -> void:
	start_pos = position
	health = MAX_HEALTH
	hearts.append($Camera2D/HUD/Control/Hearts/Heart1)
	hearts.append($Camera2D/HUD/Control/Hearts/Heart2)
	hearts.append($Camera2D/HUD/Control/Hearts/Heart3)

func _on_Player_shot() -> void:
	health -= 1
	hearts[health].texture = load("res://UI/Empty_Heart.png")
	if health == 0:
		get_tree().paused = true

func jump():
	if jumps != 1:
		velocity.y = -JUMP
		jumps += 1
		$AnimationPlayer.stop()
		$AnimationPlayer.play("Jump")

func _on_AutoJumpCheck_body_entered(_body: Node) -> void:
	#jump()
	pass
	
func distance_counter():
	$Camera2D/HUD/Control/DistanceCounter.text = str(int(global_position.x - start_pos.x)) + "m"
