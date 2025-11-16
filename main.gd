extends Node3D

@onready var camera = $CharacterBody3D/Head/Camera3D
@onready var cutscene = $cutscenes/cutscene
@onready var secondary_camera = $cutscenes/Camera3D
@onready var cutscene_animator = $cutscenes/cutscene_animator
@onready var world_env = $WorldEnvironment

@onready var dm_monster_1 = "res://monster_1.dialogue"
@onready var dm_monster_2 = "res://monster_2.dialogue"
@onready var dm_monster_3 = "res://monster_3.dialogue"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_move()
	run_cutscene("intro")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.InCutscene: 
		secondary_camera.make_current()
	if cutscene.is_playing() == false: 
		cutscene_finished()

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
	print("Cutscene ended")
	GlobalVariables.InCutscene = false
	world_env.environment.volumetric_fog_enabled = true
	camera.make_current()

func failed_game():
	print("u suck")

func passed_m1():
	print("survived monster 1")
