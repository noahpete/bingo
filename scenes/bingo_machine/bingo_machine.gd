extends Node3D
class_name BingoMachine

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func play_animation(animation_name: String) -> void:
	if animation_player.has_animation(animation_name):
		animation_player.play(animation_name)
