extends Node3D
class_name BingoMachine

const SHAKE_AMOUNT: float = 0.04
const SHAKE_FADE: float = 5.0

@export var ball_scene: PackedScene
@export var ball_count: int = 10

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visuals: Node3D = $Visuals
@onready var balls: Node3D = $Balls

var original_position: Vector3
var original_rotation: Vector3
var shake_strength := 0.0
var shake_fade := false


func _ready() -> void:
	original_position = visuals.position
	original_rotation = visuals.rotation
	_spawn_balls()
	
	
func _process(delta: float) -> void:
	if shake_strength:
		if shake_fade:
			shake_strength = lerpf(shake_strength, 0, SHAKE_FADE * delta)
		visuals.position = original_position + random_offset(shake_strength)
		visuals.rotation = original_rotation + random_offset(shake_strength) * 0.5
	else:
		visuals.position = original_position
		visuals.rotation = original_rotation
		shake_fade = false
	
	
func play_animation(animation_name: String) -> void:
	animation_player.play(animation_name)
	await animation_player.animation_finished


func start_shake() -> void:
	shake_strength = SHAKE_AMOUNT
	
	
func fade_out_shake() -> void:
	shake_fade = true
	
	
func random_offset(amount: float) -> Vector3:
	return Vector3(
		randf_range(-amount, amount),
		randf_range(-amount, amount),
		randf_range(-amount, amount)
	)


func _spawn_balls():
	for i in range(75):
		var ball_instance = ball_scene.instantiate()
		balls.add_child(ball_instance)
		ball_instance.global_transform.origin = balls.global_transform.origin + random_offset(0.02)
