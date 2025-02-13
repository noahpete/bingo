extends State
class_name PlayerTurnState

const BALL_DISPLAY_TIME := 1.0

@onready var player_turn_ui: Control = %PlayerTurnUI
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var bingo_machine: BingoMachine = %BingoMachine
@onready var item_manager: ItemManager = $"../../ItemManager"
@onready var items: Node3D = %Items
@onready var state_machine: StateMachine = $".."


func _ready() -> void:
	player_turn_ui.get_node("EndTurnButton").pressed.connect(_on_end_turn_button_pressed)
	
	
func _on_end_turn_button_pressed() -> void:
	animation_player.play("spin_180")
	await animation_player.animation_finished
	transition.emit("OpponentTurn")


func enter() -> void:
	# State initialization
	for item in items.get_children():
		if item is Item:
			item.original_position = item.global_transform.origin
	
	# State enter animations
	await _spin_and_dispense()
	
	# Check if user has switched states in mean time
	if state_machine.current_state is not PlayerTurnState:
		return
		
	await _observe_ball()
	player_turn_ui.visible = true


func exit() -> void:
	player_turn_ui.visible = false


func input_update(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		item_manager.handle_item_hovering()
			
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if item_manager.current_hovered_item is Dabber:
				transition.emit("Marking")
				

func _spin_and_dispense():
	await bingo_machine.play_animation("spin")
	await bingo_machine.play_animation("dispense")
	
	
func _observe_ball():
	animation_player.play("idle_to_display_ball")
	await animation_player.animation_finished
	await %Util.wait(BALL_DISPLAY_TIME)
	animation_player.play_backwards("idle_to_display_ball")
	await animation_player.animation_finished
