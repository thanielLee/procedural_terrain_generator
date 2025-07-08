class_name NoiseGenerator


static func generate_noise_map(map_width, map_height, scale, noise_lite):
	var noise_map = []
	
	if scale <= 0:
		scale = 0.0001
		
	noise_map.resize(map_width)
	noise_map.fill([])
	for i in range(map_width):
		noise_map[i].resize(map_height)
	
	for y in range(map_height):
		for x in range(map_width):
			var sample_x = x / scale
			var sample_y = y / scale
			
			var perlin_value = (noise_lite.get_noise_2d(sample_x, sample_y) +1.0)/2.0
			noise_map[x][y] = perlin_value
			print(x, " ", y, " ", perlin_value)
			#print(perlin_value)
			
	
	return noise_map
