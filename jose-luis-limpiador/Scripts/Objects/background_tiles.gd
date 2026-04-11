extends TileMapLayer

var dirty_tiles: int = 0
var clean_tiles: int = 0

signal upgrade_grime(value: int)
signal upgrade_clean(value: int)


func _ready() -> void:
	dirty_tiles = get_used_cells().size()
	upgrade_grime.emit(dirty_tiles)


func clean(my_position: Vector2) -> void:
	var center_tile = local_to_map(my_position)

	for x in range(-1, 2):
		for y in range(-1, 2):
			erase_cell(center_tile + Vector2i(x, y))

	clean_tiles = dirty_tiles - get_used_cells().size()
	upgrade_clean.emit(clean_tiles)
