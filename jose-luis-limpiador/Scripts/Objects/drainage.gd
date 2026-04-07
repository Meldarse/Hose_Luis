extends StaticBody2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalScene.water_pressure += 5
	body.queue_free()
