extends RigidBody2D



func _ready():
	await get_tree().create_timer(2.0).timeout
	queue_free()

func launch(direction: Vector2):
	linear_velocity = direction * GlobalScene.fire_power


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		body.clean(global_position)
		call_deferred("queue_free")
