class_name Button3D
extends Node3D

const BUTTON_PRESS_HEIGHT = 0.004
const BUTTON_PRESS_SPEED = 0.08

@onready var press: Node3D = %Press

var original_press_position: Vector3


func _ready() -> void:
	$ClickableComponent.clicked.connect(_on_button_press)
	original_press_position = press.position
	
	
func _on_button_press() -> void:
	var down_tween = create_tween()
	down_tween.tween_property(press, "position:y", original_press_position.y - BUTTON_PRESS_HEIGHT, BUTTON_PRESS_SPEED)
	await down_tween.finished
	var up_tween = create_tween()
	up_tween.tween_property(press, "position:y", original_press_position.y, BUTTON_PRESS_SPEED)
