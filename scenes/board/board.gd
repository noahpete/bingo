class_name Board
extends Node3D

const SINGLE_DIGIT_OFFSET = 4

@onready var b: Control = %B
@onready var i: Control = %I
@onready var n: Control = %N
@onready var g: Control = %G
@onready var o: Control = %O


func _ready() -> void:
	_set_board(GameManager.generate_board("player"))

	
func _set_board(board) -> void:
	for j in range(5):
		b.get_child(j).text = str(board[0][j])
		_offset_digit(board[0][j], b.get_child(j))
	for j in range(5):
		i.get_child(j).text = str(board[1][j])
		_offset_digit(board[1][j], i.get_child(j))
	for j in range(5):
		n.get_child(j).text = str(board[2][j])
		_offset_digit(board[2][j], n.get_child(j))
	for j in range(5):
		g.get_child(j).text = str(board[3][j])
		_offset_digit(board[3][j], g.get_child(j))
	for j in range(5):
		o.get_child(j).text = str(board[4][j])
		_offset_digit(board[4][j], o.get_child(j))


func _offset_digit(value: int, node: Control) -> void:
	if value < 10:
		node.position.x += SINGLE_DIGIT_OFFSET
