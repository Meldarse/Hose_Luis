extends Node2D

@export var start_point: Marker2D
@export var end_point: CharacterBody2D
@export var segments := 8
@export var sag := 20.0  # qué tanto se curva

@onready var line_2d: Line2D = $Line2D

func _ready():
	line_2d.clear_points()
	for i in range(segments + 1):
		line_2d.add_point(Vector2.ZERO)

func _process(_delta):
	var start = to_local(start_point.global_position)
	var end = to_local(end_point.global_position)

	for i in range(segments + 1):
		var t = i / float(segments)
		var pos = start.lerp(end, t)

		# curva tipo parábola (cuerda colgando)
		var curve = sin(t * PI) * sag

		pos.y += curve

		line_2d.set_point_position(i, pos)
