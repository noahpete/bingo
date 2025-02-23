class_name BallMesh
extends MeshInstance3D

@onready var color_rect: ColorRect = %ColorRect
@onready var rich_text_label: RichTextLabel = %RichTextLabel

var colors = [
	"#b45252",
	"#4b80ca",
	"#ede19e",
	"#3a3858",
	"#e5ceb4"
]

var value: int


func _ready() -> void:
	color_rect.color = Color(colors.pick_random())
	value = GameManager.draw_ball()
	rich_text_label.text = str(value)
	if value < 10:
		rich_text_label.position.x += 0
