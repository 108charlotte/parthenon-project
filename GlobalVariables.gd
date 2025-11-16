extends Node

var InCutscene = false

var passed_m1 = false
var passed_m2 = false
var passed_m3 = false

var endCutscene = false

func failed_game():
	get_tree().change_scene_to_file("res://lose_scene.tscn")
	
func _on_dialogue_event(event_data: String):
	print("Game event received: ", event_data)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
