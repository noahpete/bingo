class_name Board
extends Node3D

const SINGLE_DIGIT_OFFSET = 4

@onready var b: Control = %B
@onready var i: Control = %I
@onready var n: Control = %N
@onready var g: Control = %G
@onready var o: Control = %O


func _ready() -> void:
	_generate_random_board()
	
	
func _generate_random_board() -> void:
	_generate_column(b, 1, 15)
	_generate_column(i, 16, 30)
	_generate_column(n, 31, 45)
	_generate_column(g, 46, 60)
	_generate_column(o, 61, 75)
	
	
func _generate_column(node: Control, lo: int, hi: int) -> void:
	var values := range(lo, hi + 1)
	for label in node.get_children():
		var value = values.pick_random()
		values.remove_at(values.find(value))
		label.text = str(value)
		if value < 10:
			label.position.x += SINGLE_DIGIT_OFFSET
