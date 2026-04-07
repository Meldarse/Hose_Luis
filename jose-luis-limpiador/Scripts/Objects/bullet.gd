extends RigidBody2D

var impact: bool = false

func _ready():
	await get_tree().create_timer(2.0).timeout
	queue_free()

func launch(direction: Vector2):
	linear_velocity = direction * GlobalScene.fire_power


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is TileMapLayer and body.has_method("clean") and not impact:
		impact = true
		body.clean(global_position)
		call_deferred("queue_free")
	elif body != self and not impact:
		impact = true
		print(body)
		print("instanciar bola de agua")
		call_deferred("queue_free")
