extends Node
class_name Main


func _ready() -> void:
	$Entities/BingoMachine/AnimationPlayer.play("dispense")
