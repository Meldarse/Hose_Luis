extends StaticBody2D


func _ready() -> void:
	self.modulate = Color.BLACK


func clean() -> void:
	self.modulate = Color.WHITE
