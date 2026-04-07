extends TextureRect

@export var grain_scene: PackedScene
@export var grain_collision_shape: CircleShape2D
@export var grain_sphere_mesh: SphereMesh

var _image: Image


func _ready() -> void:
	_image = texture.get_image()
	grain_collision_shape.radius = Drop.DIAMETER / 2.0
	grain_sphere_mesh.radius = Drop.DIAMETER / 2.0 + Drop.MESH_SIZE_OFFSET / 2.0
	grain_sphere_mesh.height = Drop.DIAMETER + Drop.MESH_SIZE_OFFSET
	

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed == true:
		_generate_sand()
		queue_free()


func _generate_sand() -> void:
	var diameter := Drop.DIAMETER
	for x in range(0, size.x, diameter):
		for y in range(0, size.y, diameter):
			var local_grain_pos = Vector2(x, y)
			WorkerThreadPool.add_task(_instantiate_grain.bind(local_grain_pos + position, _get_color_at_pos(local_grain_pos)), true)


func _instantiate_grain(grain_position: Vector2, color: Color) -> void:
	if color.a == 0.0:
		return
	var new_grain = grain_scene.instantiate() as RigidBody2D
	new_grain.position = grain_position
	new_grain.modulate = color
	call_deferred("add_sibling", new_grain)


func _get_color_at_pos(grain_position: Vector2) -> Color:
	@warning_ignore("narrowing_conversion")
	var pixel_pos := Vector2i(
			remap(grain_position.x, 0.0, size.x, 0.0, _image.get_width()),
			remap(grain_position.y, 0.0, size.y, 0.0, _image.get_height()))
	return _image.get_pixelv(pixel_pos)
