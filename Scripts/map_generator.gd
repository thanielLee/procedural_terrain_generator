@tool
extends Node 
@export var map_width = 100
@export var map_height = 100
@export var noise_scale = 100.0
@export var noise_lite = FastNoiseLite

var noise_material = preload("res://Materials/noise_material.tres")

@export_tool_button("Generate Noise Map") var button = generate_map

func generate_map():
	var noise_map = NoiseGenerator.generate_noise_map(map_width, map_height, noise_scale, noise_lite)
	
	draw_noise_map(noise_map, noise_material)
	print("button pressed!")


func draw_noise_map(noise_map, noise_material):
	var width = noise_map.size()
	var height = noise_map[0].size()
	
	var noise_image = Image.create_empty(width, height, false, Image.FORMAT_RGB8)
	
	for y in range(height):
		for x in range(width):
			print(x, " ", y, " ", noise_map[x][y])
			noise_image.set_pixel(x, y, Color.BLACK.lerp(Color.WHITE, noise_map[x][y]))
			#noise_image.set_pixel(x, y, Color.RED)
			#print(Color.BLACK.lerp(Color.WHITE, noise_map[x][y]), noise_map[x][y])
	
	var image_texture = ImageTexture.create_from_image(noise_image)
	noise_material.set_texture(BaseMaterial3D.TEXTURE_ALBEDO, image_texture)
	var result = ResourceSaver.save(noise_material, "res://Materials/noise_material.tres")



func _ready():
	pass
