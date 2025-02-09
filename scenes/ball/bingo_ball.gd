extends MeshInstance3D
class_name BingoBall

@onready var color_rect: ColorRect = $SubViewport/CanvasLayer/ColorRect
@onready var rich_text_label: RichTextLabel = $SubViewport/CanvasLayer/RichTextLabel


func _ready() -> void:
	color_rect.color = Color(randf(), randf(), randf())
	
	var value = randi_range(1, 75)
	rich_text_label.text = str(value)
	if value < 10:
		rich_text_label.position.x += 3
