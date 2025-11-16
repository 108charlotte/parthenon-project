extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.02

const BOB_FREQ = 3.0
const BOB_AMP = 0.005
var t_bob = 0.0

@onready var head = $Head
@onready var camera = $Head/Camera3D

func _ready(): 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event): 
	if event is InputEventMouseMotion: 
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
	if Input.is_action_just_pressed("see_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction : Vector3 = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	
	# head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * (BOB_FREQ * 0.5)) * (BOB_AMP * 0.5)
	return pos

func setup_play_dialogue(): 
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_dialogue_ended() -> void: 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_monster_1_area_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		setup_play_dialogue()
		DialogueManager.show_example_dialogue_balloon(load("res://monster_1.dialogue"), "start")
		#DialogueManager.dialogue_ended.connect(_on_dialogue_ended, CONNECT_ONE_SHOT)
		return

func _on_monster_2_area_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		setup_play_dialogue()
		DialogueManager.show_example_dialogue_balloon(load("res://monster_2.dialogue"), "start")
		#DialogueManager.dialogue_ended.connect(_on_dialogue_ended, CONNECT_ONE_SHOT)
		return

func _on_monster_3_area_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		setup_play_dialogue()
		DialogueManager.show_example_dialogue_balloon(load("res://monster_3.dialogue"), "start")
		#DialogueManager.dialogue_ended.connect(_on_dialogue_ended, CONNECT_ONE_SHOT)
		return

func _on_end_area_entered(area):
	print('ts better work.')

func _on_ending_area_body_entered(body):
	if body is CharacterBody3D:
		setup_play_dialogue()
		print('helllo')
		if GlobalVariables.passed_m1 and GlobalVariables.passed_m2 and GlobalVariables.passed_m3:
			get_parent().run_cutscene("outro")
			GlobalVariables.endCutscene = true
			#get_tree().change_scene_to_file("res://end_scene.tscn")
		
