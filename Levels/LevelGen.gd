extends TileMap


var x = -5
var y = 18
var gen_loop = 0
var tile = Vector2(2, 1)
var chosen_tile_set = 2
var collider_offset = Vector2.ZERO
var tile_pos = Vector2.ZERO
var gen_coll_padding = 300

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
			gen_loop = 0
			var rand = rand_range(0, 2)
			#print("random: ", rand)
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
