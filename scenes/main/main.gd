extends Node
class_name Main

const BALL_DISPLAY_TIME := 1.2

@onready var bingo_machine: BingoMachine = $Entities/Pedestal/BingoMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var util: Util = $Util


func _ready() -> void:
	await spin_dispense_observe()
	#await util.wait(1.0)
	#await play_animation("spin_180")
	#await bingo_machine.play_animation("spin")
	#await bingo_machine.play_animation("dispense")


func play_animation(animation_name: StringName) -> void:
	animation_player.play(animation_name)
	await animation_player.animation_finished


func play_reversed_animation(animation_name: StringName) -> void:
	animation_player.play_backwards(animation_name)
	await animation_player.animation_finished


func spin_dispense_observe() -> void:
	await bingo_machine.play_animation("spin")
	await bingo_machine.play_animation("dispense")
	await play_animation("idle_to_display_ball")
	await util.wait(BALL_DISPLAY_TIME)
	await play_reversed_animation("idle_to_display_ball")
