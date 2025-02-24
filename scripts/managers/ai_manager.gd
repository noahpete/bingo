class_name AIManager
extends Node

var board


func _ready() -> void:
	board = GameManager.generate_board("Opponent")
