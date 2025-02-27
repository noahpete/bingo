class_name CigarettePack
extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var clickable_component: ClickableComponent = $ClickableComponent


func _ready() -> void:
	clickable_component.clicked.connect(_get_cig)
	
	
func _get_cig() -> void:
	play_animation("get_cig")

func play_animation(animation_name: StringName) -> void:
	animation_player.play(animation_name)
	await animation_player.animation_finished
