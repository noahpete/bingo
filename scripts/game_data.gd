extends Node

var is_player_turn: bool = true
var drawn_numbers_set: Dictionary = {}


func draw_ball_number() -> int:
	var number = randi_range(1, 75)
	while drawn_numbers_set.has(number):
		number = randi_range(1, 75)
	drawn_numbers_set[number] = null
	return number
