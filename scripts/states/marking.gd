extends State
class_name MarkingState

const MARKER_RAISED_HEIGHT = 0.58
const MARKER_LOWERED_HEIGHT = 0.54

const MARKER_LATERAL_TRAVEL_TIME = 0.01
const MARKER_VERTICAL_TRAVEL_TIME = 0.1

@onready var dabber: Dabber = $"../../Entities/Items/Dabber"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var input_manager: InputManager = $"../../InputManager"

var is_stamping := false


func enter() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	animation_player.play("idle_to_marking")
	
	# Avoid raycast from colliding with dabber
	dabber.get_node("StaticBody3D").collision_layer = 0
	

func exit() -> void:
	dabber.get_node("StaticBody3D").collision_layer = 1


func update(delta: float) -> void:
	if not is_stamping:
		_update_dabber_position()
	

func input_update(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_stamp_dabber()


func _update_dabber_position() -> void:
	var result = input_manager.raycast()
	if not result:
		return
	var target_position = input_manager.raycast().position
	target_position.y = MARKER_RAISED_HEIGHT
	var tween = create_tween()
	tween.tween_property(dabber, "global_transform:origin", target_position, MARKER_LATERAL_TRAVEL_TIME)


func _stamp_dabber() -> void:
	is_stamping = true
	var target_position = dabber.position
	target_position.y = MARKER_LOWERED_HEIGHT
	var tween = create_tween()
	tween.tween_property(dabber, "global_transform:origin", target_position, MARKER_VERTICAL_TRAVEL_TIME)
	await tween.finished
	
	var raise_tween = create_tween()
	target_position.y = MARKER_RAISED_HEIGHT
	raise_tween.tween_property(dabber, "global_transform:origin", target_position, MARKER_VERTICAL_TRAVEL_TIME)
	await raise_tween.finished
	
	is_stamping = false
