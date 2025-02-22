class_name Ball
extends RigidBody3D

@export var game_manager: GameManager

@onready var color_rect: ColorRect = %ColorRect
@onready var rich_text_label: RichTextLabel = %RichTextLabel

var colors = [
	"#b45252",
	"#4b80ca",
	"#ede19e",
	"#3a3858",
	"#e5ceb4"
]


func _ready() -> void:
	color_rect.color = Color(colors.pick_random())
	var value = game_manager.draw_ball()
	rich_text_label.text = str(value)
	if value < 10:
		rich_text_label.position.x += 3
