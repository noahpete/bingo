extends Node
class_name Util


func wait(time: float) -> void:
	await get_tree().create_timer(time).timeout
