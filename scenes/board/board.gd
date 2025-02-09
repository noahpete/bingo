extends Node3D
class_name Board

const SINGLE_DIGIT_CENTER_OFFSET = 4

@onready var b_node: Control = $SubViewport/CanvasLayer/B
@onready var i_node: Control = $SubViewport/CanvasLayer/I
@onready var n_node: Control = $SubViewport/CanvasLayer/N
@onready var g_node: Control = $SubViewport/CanvasLayer/G
@onready var o_node: Control = $SubViewport/CanvasLayer/O


func _ready() -> void:
	_generate_random_board()
	
	
func _generate_random_board() -> void:
	_generate_board_column(b_node, 1, 15)
	_generate_board_column(i_node, 16, 30)
	_generate_board_column(n_node, 31, 45)
	_generate_board_column(g_node, 46, 60)
	_generate_board_column(o_node, 61, 75)
			
func _generate_board_column(node: Control, lo: int, hi: int) -> void:
	var values := range(lo, hi + 1)
	for label in node.get_children():
		var value = values.pick_random()
		values.remove_at(values.find(value))
		label.text = str(value)
		if value < 10:
			label.position.x += SINGLE_DIGIT_CENTER_OFFSET
