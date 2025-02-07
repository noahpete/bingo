extends Node
class_name Main

signal enter_marking_state

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var players: Array[Player]

enum GameState {
	IDLE,
	ANIMATION,
	MARKING
}

var state: GameState = GameState.IDLE


func _ready() -> void:
	players = [
		Player.new(false),
		Player.new(true)
	]
	_on_game_start()
	
func _input(event: InputEvent) -> void:
	if state == GameState.IDLE:
		if event is InputEventMouseMotion:
			print(event.position)
		elif event is InputEventMouseButton:
			pass
			#if event.button_index == 1:
				#enter_marking_state.emit()

func _on_game_start() -> void:
	# TODO: Play start cutscene
	for player in players:
		await _take_turn(player)
	pass


func _take_turn(player: Player) -> void:
	if player.is_cpu:
		_handle_cpu_turn()
		return
	
	animation_player.play("get_ball")
	state = GameState.ANIMATION
	await animation_player.animation_finished
	
	# Start capturing input again
	state = GameState.IDLE
	
	await enter_marking_state
	state = GameState.MARKING
	
	print("DONE")
	# execute more code
	
func _handle_cpu_turn() -> void:
	pass
	
