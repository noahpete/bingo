class_name GameManager
extends Node

const NUMBER_OF_BALLS := 75

static var turn_number: int = 0
static var boards: Dictionary = {}
static var balls: Array[int]
static var drawn_balls: Array[int]


func _ready() -> void:
	for i in range(NUMBER_OF_BALLS):
		balls.append(i + 1)
			
	
static func debug_draw_ball(value: int) -> int:
	if value in drawn_balls:
		return -1
	if value not in balls:
		return -1
	balls.remove_at(balls.find(value))
	drawn_balls.append(value)
	return value

		
static func has_bingo(player: StringName) -> bool:
	var board = boards[player]
	var bingo := false
	if not board:
		return bingo
	for col in board:
		if _check_column(col):
			bingo = true
	for i in range(5):
		if _check_row(i, board):
			bingo = true
	if _check_diagonals(board):
		bingo = true
	return bingo


static func draw_ball() -> int:
	if not balls:
		return -1
	var value = balls.pick_random()
	balls.remove_at(balls.find(value))
	drawn_balls.append(value)
	return value


static func generate_board(player: StringName):
	var b_col = _generate_column(1, 15)
	var i_col = _generate_column(16, 30)
	var n_col = _generate_column(31, 45)
	var g_col = _generate_column(46, 60)
	var o_col = _generate_column(61, 75)
	boards[player] = [b_col, i_col, n_col, g_col, o_col]
	return [b_col, i_col, n_col, g_col, o_col]


static func remove_spot_from_play(row: int, col: int) -> void:
	for board in boards.values():
		board[col][row] = -1
	
	
static func _generate_column(lo: int, hi: int) -> Array[int]:
	var values := range(lo, hi + 1)
	var column: Array[int] = []
	for _i in range(5):
		var value = values.pick_random()
		values.remove_at(values.find(value))
		column.append(value)
	return column
	
	
static func _check_column(column: Array[int]) -> bool:
	for value in column:
		if value not in drawn_balls:
			return false
	return true


static func _check_row(row_index: int, board) -> bool:
	for col in board:
		if col[row_index] not in drawn_balls:
			return false
	return true
	
	
static func _check_diagonals(board) -> bool:
	var left_to_right_bingo := true
	for i in range(5):
		if board[i][i] not in drawn_balls:
			left_to_right_bingo = false
	
	var right_to_left_bingo := true
	for i in range(5):
		if board[4 - i][i] not in drawn_balls:
			right_to_left_bingo = false
	
	return left_to_right_bingo or right_to_left_bingo
