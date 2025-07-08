@tool
extends Node 

signal values_changed

@export var map_width : int : 
	set(value):
		
		map_width = value
		values_changed.emit()
		
@export var map_height : int : 
	set(value):
		
		map_height = value
		values_changed.emit()
		
@export var noise_scale : float : 
	set(value):
		
		print(value, " ", noise_scale)
		noise_scale = value
		values_changed.emit()
	
@export var octaves : int : 
	set(value):
		
		octaves = value
		values_changed.emit()
		
@export var lacunarity : float : 
	set(value):
		
		lacunarity = value
		values_changed.emit()

@export var persistence : float : 
	set(value):
		
		persistence = value
		values_changed.emit()
		
@export var noise_lite : FastNoiseLite :
	set(value):
		
		noise_lite = value
		values_changed.emit()



var noise_material = preload("res://Materials/noise_material.tres")

@export_tool_button("Generate Noise Map") var button = generate_map

	

func generate_map():
	print(map_width, " ", map_height)
	var noise_map = NoiseGenerator.generate_noise_map(map_width, map_height, noise_scale, noise_lite, octaves, persistence, lacunarity)
	draw_noise_map(noise_map, noise_material)
	print("button pressed!")


func draw_noise_map(noise_map, noise_material):
	var width = noise_map.size()
	var height = noise_map[0].size()
	
	var noise_image = Image.create_empty(width, height, false, Image.FORMAT_RGB8)
	
	for x in range(width):
		for y in range(height):
			noise_image.set_pixel(x, y, Color.BLACK.lerp(Color.WHITE, noise_map[x][y]))
			#if y == 0:
				#print(x, " ", y, " ", noise_map[x])
			#noise_image.set_pixel(x, y, Color.RED)
			#print(Color.BLACK.lerp(Color.WHITE, noise_map[x][y]), noise_map[x][y])
		#print(noise_map[y])
	
	var image_texture = ImageTexture.create_from_image(noise_image)
	noise_material.set_texture(BaseMaterial3D.TEXTURE_ALBEDO, image_texture)
	var result = ResourceSaver.save(noise_material, "res://Materials/noise_material.tres")



func _ready():
	values_changed.connect(generate_map)
	pass
