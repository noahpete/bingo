extends State
class_name MarkingState

const MARKER_RAISED_HEIGHT = 0.54
const MARKER_TRAVEL_TIME = 0.01

@onready var marker: Marker = $"../../Entities/Items/Marker"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var input_manager: InputManager = $"../../InputManager"


func enter() -> void:
	animation_player.play("idle_to_marking")
	
	# Avoid raycast from colliding with marker
	var static_body = marker.get_node("StaticBody3D") as StaticBody3D
	static_body.collision_layer = 0
	

func exit() -> void:
	marker.get_node("StaticBody3D").collision_layer = 1


func update(delta: float) -> void:
	_update_marker_position()


func _update_marker_position() -> void:
	var result = input_manager.raycast()
	if not result:
		return
	var target_position = input_manager.raycast().position
	print(target_position)
	target_position.y = MARKER_RAISED_HEIGHT
	var tween = create_tween()
	tween.tween_property(marker, "global_transform:origin", target_position, MARKER_TRAVEL_TIME)
