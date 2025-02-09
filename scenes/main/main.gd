extends Node
class_name Main

@onready var bingo_machine: BingoMachine = $Entities/BingoMachine

func _ready() -> void:
	await bingo_machine.play_animation("spin")
	await bingo_machine.play_animation("dispense")
