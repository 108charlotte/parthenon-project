extends Node3D

@onready var camera = $CharacterBody3D/Head/Camera3D
@onready var cutscene = $cutscenes/cutscene
@onready var secondary_camera = $cutscenes/Camera3D
@onready var cutscene_animator = $cutscenes/cutscene_animator
@onready var world_env = $WorldEnvironment

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_move()
	run_cutscene("intro")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.InCutscene: 
		secondary_camera.make_current()
	if cutscene.is_playing() == false:
		if GlobalVariables.endCutscene == false: 
			cutscene_finished()
		else:
			get_tree().change_scene_to_file("res://end_scene.tscn")
		

func setup_move(): 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	cutscene.visible = false

func run_cutscene(path): 
	world_env.environment.volumetric_fog_enabled = false
	GlobalVariables.InCutscene = true
	cutscene.visible = true
	cutscene.play(path)
	print("In Cutscene")

func cutscene_finished(): 
	GlobalVariables.InCutscene = false
	world_env.environment.volumetric_fog_enabled = true
	camera.make_current()
