extends Node3D
class_name BingoMachine

const SHAKE_AMOUNT: float = 0.05
const SHAKE_FADE: float = 5.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visuals: Node3D = $Visuals

var original_position: Vector3
var shake_strength := 0.0
var shake_fade := false


func _ready() -> void:
	original_position = visuals.position
	
	
func _process(delta: float) -> void:
	if shake_strength:
		if shake_fade:
			shake_strength = lerpf(shake_strength, 0, SHAKE_FADE * delta)
		visuals.position = original_position + random_offset()
	else:
		shake_fade = false
	
	
func play_animation(animation_name: String) -> void:
	animation_player.play(animation_name)
	await animation_player.animation_finished


func start_shake() -> void:
	shake_strength = SHAKE_AMOUNT
	
	
func fade_out_shake() -> void:
	shake_fade = true
	
	
func random_offset() -> Vector3:
	return Vector3(
		randf_range(-shake_strength, shake_strength),
		randf_range(-shake_strength, shake_strength),
		randf_range(-shake_strength, shake_strength)
	)
