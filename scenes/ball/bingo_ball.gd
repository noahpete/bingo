extends MeshInstance3D
class_name BingoBall

@onready var color_rect: ColorRect = $SubViewport/CanvasLayer/ColorRect
@onready var rich_text_label: RichTextLabel = $SubViewport/CanvasLayer/RichTextLabel


func _ready() -> void:
	color_rect.color = Color(randf(), randf(), randf())
	rich_text_label.text = str(randi_range(1, 99))
