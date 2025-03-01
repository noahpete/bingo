class_name BallMesh
extends MeshInstance3D

const DISSOLVE_DURATION_SEC = 0.5

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


func dissolve() -> void:
	if not get_active_material(0):
		return
	
	var material = get_active_material(0) as ShaderMaterial
	material.set_shader_parameter("progress", 0.0)

	var tween = get_tree().create_tween()
	tween.tween_method(
		func(progress): material.set_shader_parameter("progress", progress), 
		0.0,  
		1.0,  
		DISSOLVE_DURATION_SEC
	)
	await tween.finished
	
	queue_free()
