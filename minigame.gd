extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_level(): 
	var num_stars = GlobalVariables.num_stars
	for i in range(len(num_stars)): 
		var star = Sprite2D.new()
		star.texture = load("res://icon.svg")
		add_child(star)
	print("done")
