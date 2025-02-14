extends State
class_name MarkingState

const MARKER_RAISED_HEIGHT = 0.58
const MARKER_LOWERED_HEIGHT = 0.54

const MARKER_LATERAL_TRAVEL_TIME = 0.01
const MARKER_VERTICAL_TRAVEL_TIME = 0.1

@onready var dauber: Dabber = $"../../Entities/Items/Dabber"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var input_manager: InputManager = $"../../InputManager"
@onready var timer: Timer = $"../../Timer"
@onready var dauber_return_area: Node3D = $"../../Entities/Items/DabberReturnArea"

var is_stamping := false
var dabbing_progress := 0.0


func enter() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	animation_player.play("idle_to_marking")
	var tween = create_tween()
	tween.tween_property(dauber, "global_transform:origin:y", MARKER_RAISED_HEIGHT, MARKER_VERTICAL_TRAVEL_TIME)
	
	var rotation_tween = create_tween()
	var target = Vector3(0.0, deg_to_rad(51.8), deg_to_rad(180.0))
	rotation_tween.tween_property(dauber, "rotation", target, MARKER_VERTICAL_TRAVEL_TIME)
	
	dauber_return_area.visible = true
	dauber_return_area.get_node("Area3D").collision_layer = 2
	
	# Avoid raycast from colliding with dauber
	dauber.get_node("StaticBody3D").collision_layer = 0
	dauber.get_node("Area3D").collision_layer = 0
	

func exit() -> void:
	dauber.get_node("StaticBody3D").collision_layer = 1
	dauber.get_node("Area3D").collision_layer = 1
	
	dauber_return_area.visible = false
	dauber_return_area.get_node("Area3D").collision_layer = 0
	
	animation_player.play_backwards("idle_to_marking")
	
	var rotation_tween = create_tween()
	rotation_tween.tween_property(dauber, "rotation", dauber.original_rotation, 0.5)
	
	var position_tween = create_tween()
	position_tween.tween_property(dauber, "global_transform:origin", dauber.original_position, 0.5)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func update(delta: float) -> void:
	_update_dauber_xz_position()
	

func input_update(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var result = input_manager.raycast(true, 0b10)
				if result:
					transition.emit("PlayerTurn")
				else:
					_dab()
		

func _update_dauber_xz_position() -> void:
	var result = input_manager.raycast()
	if not result:
		return
		
	var target_position = result.position

	var x_tween = create_tween()
	x_tween.tween_property(dauber, "global_transform:origin:x", target_position.x, MARKER_LATERAL_TRAVEL_TIME)

	var z_tween = create_tween()
	z_tween.tween_property(dauber, "global_transform:origin:z", target_position.z, MARKER_LATERAL_TRAVEL_TIME)


func _dab() -> void:
	var down_tween = create_tween()
	down_tween.tween_property(dauber, "global_transform:origin:y", MARKER_LOWERED_HEIGHT, MARKER_VERTICAL_TRAVEL_TIME)
	dauber.dab()
	await down_tween.finished
	
	var up_tween = create_tween()
	up_tween.tween_property(dauber, "global_transform:origin:y", MARKER_RAISED_HEIGHT, MARKER_VERTICAL_TRAVEL_TIME)
