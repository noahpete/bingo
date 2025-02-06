extends MeshInstance3D
class_name BingoBall

var colors = [
	Color("603b3a"),
	Color("77744f"),
	Color("4f7754"),
	Color("4f5277"),
	Color("2f213b")
]


func _ready() -> void:
	var random_color = colors[randi() % colors.size()]
	var solid_texture = generate_solid_color_texture(random_color)
	apply_texture_to_mesh(solid_texture)
	
	
func generate_solid_color_texture(color: Color) -> ImageTexture:
	var img = Image.create(128, 128, false, Image.FORMAT_RGBA8)
	img.fill(color)
	var texture = ImageTexture.create_from_image(img)
	return texture
	
	
func apply_texture_to_mesh(texture: ImageTexture):
	if mesh.surface_get_material(0) == null:
		var material = StandardMaterial3D.new()
		mesh.surface_set_material(0, material)
		material.albedo_texture = texture
	else:
		var material = mesh.surface_get_material(0) as StandardMaterial3D
		material.albedo_texture = texture
