extends Node2D

@onready var victory: AudioStreamPlayer = $Victory

var dirty_tiles: int = 0
var clean_tiles: int = 0
var clean_background: int = 0


func _on_level_change_body_entered(_body: Node2D) -> void:
	GlobalScene.grime = dirty_tiles
	GlobalScene.clean = clean_tiles + clean_background


func _on_interactive_tiles_upgrade_grime(value: int) -> void:
	dirty_tiles += value


func _on_background_tiles_upgrade_grime(value: int) -> void:
	dirty_tiles += value


func _on_interactive_tiles_upgrade_clean(value: int) -> void:
	clean_tiles = value
	level_clean()


func _on_background_tiles_upgrade_clean(value: int) -> void:
	clean_background = value
	level_clean()


func level_clean() -> void:
	GlobalScene.clean = clean_tiles + clean_background
	if dirty_tiles == clean_tiles + clean_background:
		victory.play()
