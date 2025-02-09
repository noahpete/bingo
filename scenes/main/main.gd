extends Node
class_name Main

@onready var bingo_machine: BingoMachine = $Entities/BingoMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	#animation_player.play("temp")
	#await bingo_machine.play_animation("spin")
	pass
	#await bingo_machine.play_animation("dispense")
