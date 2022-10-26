extends TileMap


var x = -5
var y = 18
var gen_loop = 0
var tile = Vector2(2, 1)
var chosen_tile_set = 2
var collider_offset = Vector2.ZERO
var tile_pos = Vector2.ZERO
var gen_coll_padding = 300
onready var blueberry_ref = preload("res://Objects/Blueberry.tscn")
onready var enemy_ref = preload("res://Objects/Enemy.tscn")

func _ready():
	randomize()
	set_gen_collider()

func generate_level(loops : int):
	for i in range(loops):
		tile_pos = Vector2(x ,y)
		var y_change = 0
		set_cellv(tile_pos, chosen_tile_set, false, false, false, tile)
		x += 1
		if gen_loop == 12:
			spawn_blueberry(Vector2(x, y))
			spawn_enemy(Vector2(x, y))
			gen_loop = 0
			var rand = rand_range(0, 2)
			if i == 12:
				y_change = 1
				y += y_change
			else:
				if rand < 1:
					y_change = 1
					y += y_change
				else:
					y_change = -1
					y += y_change
		else:
			gen_loop += 1
			
		if i != loops:
			tile = choose_tile(y_change)

func choose_tile(y_change : int):
	var tile_coords = Vector2()
	
	if y_change == 1:
		tile_coords = Vector2(2, 1)
		set_cellv(Vector2(x - 1, y), chosen_tile_set, false, false, false, Vector2(5, 2))
		set_cellv(Vector2(x - 1, y - 1), chosen_tile_set, false, false, false, Vector2(4, 1))
	elif y_change == -1:
		tile_coords = Vector2(0, 1)
		set_cellv(Vector2(x, y + 1), chosen_tile_set, false, false, false, Vector2(6, 2))
	else:
		tile_coords = Vector2(2,1)
	
	return tile_coords


func _on_GenerationCollider_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		set_gen_collider()

func set_gen_collider():
	generate_level(144)
	collider_offset = map_to_world(tile_pos)
	$GenerationCollider.global_position = collider_offset
	$GenerationCollider.global_position.x -= gen_coll_padding

func spawn_blueberry(spawn_position : Vector2):
	var new_berry = blueberry_ref.instance()
	new_berry.global_position = map_to_world(spawn_position - Vector2(6, 1))
	if rand_range(0, 3) < 1:
		call_deferred("add_child", new_berry)
		
func spawn_enemy(spawn_position : Vector2):
	var new_enemy = enemy_ref.instance()
	new_enemy.global_position = map_to_world(spawn_position - Vector2(8, 1))
	if rand_range(0, 3) < 1:
		call_deferred("add_child", new_enemy)
