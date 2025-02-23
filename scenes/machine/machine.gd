class_name Machine
extends Node3D

const BALL_ROLL_POSITION = Vector3(0.0, -0.012, 0.044)
const BALL_ROLL_ROTATION = Vector3(deg_to_rad(1080+130), 0.0, deg_to_rad(180))
const BALL_DURATION_SEC = 4.0

@export var ball_mesh_scene: PackedScene
@export var ball_spawn: Node3D

@onready var cage: Node3D = $Cage
@onready var screen: Screen = $Screen

func spin_cage() -> void:
	var tween = create_tween()
	tween.tween_property(
		cage, 
		"rotation:y", 
		cage.rotation.y + deg_to_rad(1080), 
		2.0
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	await tween.finished


func dispense_ball() -> void:
	var ball = ball_mesh_scene.instantiate() as BallMesh
	ball_spawn.add_child(ball)
	
	ball.rotation = Vector3(0.0, 0.0, deg_to_rad(180))
	
	var position_tween = create_tween()
	var rotation_tween = create_tween()
	
	position_tween.tween_property(ball, "position", BALL_ROLL_POSITION, 1.0)
	rotation_tween.tween_property(ball, "rotation", BALL_ROLL_ROTATION, 1.0)
	
	await position_tween.finished
	screen.set_display(str(ball.value))
	
	await get_tree().create_timer(BALL_DURATION_SEC).timeout
	ball.dissolve()
	

func set_display(text: String) -> void:
	screen.set_display(text)
