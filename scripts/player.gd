extends Node
class_name Player

var is_cpu: bool

func _init(is_cpu_player: bool) -> void:
	is_cpu = is_cpu_player


func take_turn() -> void:
	pass
