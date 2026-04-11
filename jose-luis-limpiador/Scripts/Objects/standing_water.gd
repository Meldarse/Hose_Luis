@tool
extends Node2D

@export var texture_water: Texture2D
@export var drop_scene: PackedScene

@export_category("dimensions")
@export var width: int = 1:
	set(value):
		width = value
		if Engine.is_editor_hint() and is_inside_tree():
			upgrade()
@export var height: int = 1:
	set(value):
		height = value
		if Engine.is_editor_hint() and is_inside_tree():
			upgrade()

@export_category("drop")
@export var number: int = 1

@onready var collision_detector: CollisionShape2D = $Detector/CollisionDetector

const CELL_SIZE: int = 16
var tiles_position: Array[Vector2] = []


func _ready() -> void:
	if not Engine.is_editor_hint():	
		upgrade()


func upgrade() -> void:
	for node in get_children():
		if node is Sprite2D:
			node.queue_free()

	for h in range(height):
		for w in range(width):
			var tile: Sprite2D = Sprite2D.new()
			tile.texture = texture_water
			var pos_x = -width * CELL_SIZE /2.0 + CELL_SIZE / 2.0 + w * CELL_SIZE
			var pos_y = -height * CELL_SIZE /2.0 + CELL_SIZE /2.0 + h * CELL_SIZE
			tile.position = Vector2(pos_x, pos_y)
			tiles_position.append(global_position + tile.global_position)
			add_child(tile)
	
	collision_detector.shape.set_size(Vector2(width * CELL_SIZE + 4,
	height * CELL_SIZE + 4))


func spawn_drop() -> void:
	var main_scene = get_tree().current_scene
	var water_container = main_scene.get_node("%WaterContainer")
	var size = tiles_position.size()

	for value in range(number):
		var drop_water = drop_scene.instantiate()
		var index = value % size
		var base_pos = tiles_position[index]
		var noise_offset = Vector2(randf_range(-3.0, 3.0),
		randf_range(-3, 3.0))
		drop_water.global_position = base_pos + noise_offset
		water_container.call_deferred("add_child", drop_water)
	call_deferred("queue_free")

func _on_detector_body_entered(_body: Node2D) -> void:
	spawn_drop()
