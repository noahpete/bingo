class_name CigarettePack
extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var clickable_component: ClickableComponent = $ClickableComponent
@onready var hover_component: HoverComponent = $HoverComponent


func _ready() -> void:
	pass
	#clickable_component.clicked.connec
	

func play_animation(animation_name: StringName) -> void:
	animation_player.play(animation_name)
	await animation_player.animation_finished


func play_get_cig_animation() -> void:
	play_animation("get_cig")
