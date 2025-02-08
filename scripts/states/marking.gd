extends State
class_name MarkingState

const MARKER_RAISED_HEIGHT = 0.58
const MARKER_LOWERED_HEIGHT = 0.54

const MARKER_LATERAL_TRAVEL_TIME = 0.01
const MARKER_VERTICAL_TRAVEL_TIME = 0.1

@onready var dabber: Dabber = $"../../Entities/Items/Dabber"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var input_manager: InputManager = $"../../InputManager"
@onready var timer: Timer = $"../../Timer"

var is_stamping := false
var dabbing_progress := 0.0


func enter() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	animation_player.play("idle_to_marking")
	var tween = create_tween()
	tween.tween_property(dabber, "global_transform:origin:y", MARKER_RAISED_HEIGHT, MARKER_VERTICAL_TRAVEL_TIME)
	
	# Avoid raycast from colliding with dabber
	dabber.get_node("StaticBody3D").collision_layer = 0
	

func exit() -> void:
	dabber.get_node("StaticBody3D").collision_layer = 1


func update(delta: float) -> void:
	_update_dabber_xz_position()
	

func input_update(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_dab()


func _update_dabber_xz_position() -> void:
	var result = input_manager.raycast()
	if not result:
		return
		
	var target_position = result.position

	var x_tween = create_tween()
	x_tween.tween_property(dabber, "global_transform:origin:x", target_position.x, MARKER_LATERAL_TRAVEL_TIME)

	var z_tween = create_tween()
	z_tween.tween_property(dabber, "global_transform:origin:z", target_position.z, MARKER_LATERAL_TRAVEL_TIME)


func _dab() -> void:
	var down_tween = create_tween()
	down_tween.tween_property(dabber, "global_transform:origin:y", MARKER_LOWERED_HEIGHT, MARKER_VERTICAL_TRAVEL_TIME)
	await down_tween.finished
	var up_tween = create_tween()
	up_tween.tween_property(dabber, "global_transform:origin:y", MARKER_RAISED_HEIGHT, MARKER_VERTICAL_TRAVEL_TIME)
