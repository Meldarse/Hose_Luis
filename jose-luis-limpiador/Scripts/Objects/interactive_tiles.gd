extends TileMapLayer


func clean(my_position: Vector2) -> void:
	var center_tile = local_to_map(my_position)
	var tile
	if center_tile + Vector2i(-1, 0) != null:
		tile = center_tile + Vector2i(-1, 0)
		erase_cell(tile)
	if center_tile + Vector2i(1, 0) != null:
		tile = center_tile + Vector2i(1, 0)
		erase_cell(tile)
	if center_tile + Vector2i(0, -1) != null:
		tile = center_tile + Vector2i(0, -1)
		erase_cell(tile)
	if center_tile + Vector2i(0, 1) != null:
		tile = center_tile + Vector2i(0, 1)
		erase_cell(tile)
