extends TileMapLayer

var value: int = 0

func _ready() -> void:
	value = get_used_cells().size()
	GlobalScene.grime += get_used_cells().size()
	

func clean(my_position: Vector2) -> void:
	var center_tile = local_to_map(my_position)

	for x in range(-1, 2):
		for y in range(-1, 2):
			erase_cell(center_tile + Vector2i(x, y))


	GlobalScene.clean_back = value - get_used_cells().size()
