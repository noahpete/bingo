extends MeshInstance3D
class_name BingoBallMesh

@onready var color_rect: ColorRect = $SubViewport/CanvasLayer/ColorRect
@onready var rich_text_label: RichTextLabel = $SubViewport/CanvasLayer/RichTextLabel

var colors = [
	"#b45252",
	"#4b80ca",
	"#ede19e",
	"#3a3858",
	"#e5ceb4"
]

func _ready() -> void:
	color_rect.color = Color(colors.pick_random())
	
	var value = randi_range(1, 75)
	rich_text_label.text = str(value)
	if value < 10:
		rich_text_label.position.x += 3
