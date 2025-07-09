@tool
extends Node 

signal values_changed

@export var map_width : int : 
	set(value):
		map_width = max(value, 1)
		var mesh = $"../Terrain Plane"
		if mesh != null:
			mesh.scale = Vector3(map_width/100.0, 1, mesh.scale.z)
		values_changed.emit() 
		
@export var map_height : int : 
	set(value):
		map_height = max(value, 1)
		var mesh = $"../Terrain Plane"
		if mesh != null:
			mesh.scale = Vector3(mesh.scale.x, 1, map_height/100.0)
		values_changed.emit()
		
@export var noise_scale : float : 
	set(value):
		noise_scale = value
		values_changed.emit()
	
@export var octaves : int : 
	set(value):
		octaves = max(value, 0)
		values_changed.emit()
		
@export var lacunarity : float : 
	set(value):
		lacunarity = max(value, 1)
		values_changed.emit()

@export_range(0, 1, 0.0001) var persistence : float : 
	set(value):
		persistence = value
		values_changed.emit()

@export var seed : int : 
	set(value):
		seed = value
		values_changed.emit()

@export var offset : Vector2 : 
	set(value):
		offset = value
		values_changed.emit()
		
@export var noise_lite : FastNoiseLite :
	set(value):
		noise_lite = value
		values_changed.emit()
		
enum DrawMode {NOISE_MAP, COLOR_MAP}

@export var draw_mode : DrawMode :
	set(value):
		draw_mode = value
		values_changed.emit()

@export var regions: Array[TerrainType]
var noise_material = preload("res://Materials/noise_material.tres")

@export_tool_button("Generate Noise Map") var button = generate_map

func generate_map():
	var noise_map = NoiseGenerator.generate_noise_map(map_width, map_height, noise_scale, noise_lite, seed, octaves, persistence, lacunarity, offset)
	var color_map = []
	
	for y in range(map_height):
		var current_row = []
		for x in range(map_width):
			var current_height = noise_map[y][x]
			for i in range(regions.size()):
				if current_height <= regions[i].height:
					current_row.append(regions[i].color)
					break
		color_map.append(current_row)
	
	
	if draw_mode == DrawMode.NOISE_MAP:
		draw_map(noise_map)
	elif draw_mode == DrawMode.COLOR_MAP:
		draw_map(color_map)
		
	#elif draw_mode == DrawMode.COLOR_MAP:
		
	print("button pressed!")


func draw_map(current_map):
	var image_texture : ImageTexture
	
	if draw_mode == DrawMode.NOISE_MAP:
		image_texture = TextureGenerator.texture_from_height_map(current_map)
	elif draw_mode == DrawMode.COLOR_MAP:
		print("woah ", current_map.size(), " ", current_map[0].size())
		image_texture = TextureGenerator.texture_from_color_map(current_map, map_width, map_height)

	noise_material.set_texture(BaseMaterial3D.TEXTURE_ALBEDO, image_texture)
	noise_material.texture_repeat = false
	var result = ResourceSaver.save(noise_material, "res://Materials/noise_material.tres")

	
func _ready():
	values_changed.connect(generate_map)
	pass
