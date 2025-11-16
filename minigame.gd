extends Node2D

var star_positions: Array[Vector2] = []

func _ready() -> void:
	generate_level()

func generate_level():
	star_positions.clear()
	var num_stars = 5
	for i in range(num_stars):
		var star = Sprite2D.new()
		star.texture = load("res://icon.svg")
		var pos = Vector2(randi_range(0, 640), randi_range(0, 400))
		star.position = pos
		add_child(star)
		star_positions.append(pos)

func _draw():
	for i in range(star_positions.size() - 1):
		var from = star_positions[i]
		var to = star_positions[i + 1]

		draw_line(from, to, Color(0, 0, 1), 5)
		draw_line(from, to, Color(1, 1, 1), 1)
