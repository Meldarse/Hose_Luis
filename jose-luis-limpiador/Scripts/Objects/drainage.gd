extends StaticBody2D

@onready var upgrade_sfx: AudioStreamPlayer = $upgradeSFX
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not animation_player.is_playing():
		animation_player.play("upgrade")
		upgrade_sfx.play()
	GlobalScene.water_pressure += 5
	body.queue_free()
