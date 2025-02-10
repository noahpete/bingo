extends Node3D
class_name BingoMachine

const SHAKE_AMOUNT: float = 0.01
const SHAKE_FADE: float = 5.0

@export var ball_scene: PackedScene
@export var ball_count: int = 10

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visuals: Node3D = $Visuals
@onready var balls: Node3D = $Balls
@onready var cage_area_3d: Area3D = $Visuals/Cage/Area3D

var original_position: Vector3
var original_rotation: Vector3
var shake_strength := 0.0
var shake_fade := false

var i := 0


func _ready() -> void:
	original_position = visuals.position
	original_rotation = visuals.rotation
	cage_area_3d.body_exited.connect(_on_cage_area_exited)
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
		

func _on_cage_area_exited(body) -> void:
	if body.is_in_group("balls"):
		i += 1
		body.queue_free()
		_spawn_ball()
	
	
func play_animation(animation_name: String) -> void:
	animation_player.play(animation_name)
	await animation_player.animation_finished


func start_shake() -> void:
	shake_strength = SHAKE_AMOUNT
	
	
func fade_out_shake() -> void:
	shake_fade = true
	
	
func add_random_velocity_to_balls() -> void:
	for ball in balls.get_children():
		ball.set_velocity(random_offset(1.0))
	
	
func random_offset(amount: float) -> Vector3:
	return Vector3(
		randf_range(-amount, amount),
		randf_range(-amount, amount),
		randf_range(-amount, amount)
	)


func _spawn_balls():
	for i in range(75):
		_spawn_ball()
		
		
func _spawn_ball() -> void:
	var ball_instance = ball_scene.instantiate()
	balls.add_child(ball_instance)
	ball_instance.global_transform.origin = balls.global_transform.origin + random_offset(0.02)
