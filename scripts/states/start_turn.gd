extends State
class_name StartTurnState

# State where a turn has just started; runs start turn animations.

const BALL_DISPLAY_TIME := 1.0

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var bingo_machine: BingoMachine = %BingoMachine


func enter() -> void:
	await bingo_machine.play_animation("spin")
	await bingo_machine.play_animation("dispense")
	
	if GameData.is_player_turn:
		animation_player.play("idle_to_display_ball")
		await animation_player.animation_finished
		await %Util.wait(BALL_DISPLAY_TIME)
		animation_player.play_backwards("idle_to_display_ball")
		await animation_player.animation_finished
	
	if GameData.is_player_turn:
		transition.emit("PlayerTurn")
	else:
		transition.emit("OpponentTurn")
