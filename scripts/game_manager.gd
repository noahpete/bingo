class_name GameManager
extends Node

@export var camera_manager: CameraManager

static var boards: Dictionary = {}


static func generate_board(player: String):
	var b_col = _generate_column(1, 15)
	var i_col = _generate_column(16, 30)
	var n_col = _generate_column(31, 45)
	var g_col = _generate_column(46, 60)
	var o_col = _generate_column(61, 75)
	boards[player] = [b_col, i_col, n_col, g_col, o_col]
	return [b_col, i_col, n_col, g_col, o_col]
	
	
static func _generate_column(lo: int, hi: int):
	var values := range(lo, hi + 1)
	var column := []
	for _i in range(5):
		var value = values.pick_random()
		values.remove_at(values.find(value))
		column.append(value)
	return column
