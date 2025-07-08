class_name NoiseGenerator


static func generate_noise_map(map_width, map_height, scale, noise_lite, octaves, persistence, lacunarity):
	var noise_map = []
	
	if scale <= 0:
		scale = 0.0001
		
	map_width = max(1, map_width)
	map_height = max(1, map_height)
		
	# This following line of code doesn't work because for some reason each row is by reference (Whenever you modify
	# Row x, all other rows get replaced with the same value
	
	#noise_map.resize(map_width)
	#noise_map.fill([])
	#for i in range(map_width):
		#noise_map[i].resize(map_height)
	
	var max_noise_height = -10000000.0
	var min_noise_height = 1000000.0

	for x in range(map_width):
		var current_row = []
		for y in range(map_height):
			
			var amplitude = 1
			var frequency = 1
			var noise_height = 0


			for i in range(octaves):
				var sample_x = x / scale * frequency
				var sample_y = y / scale * frequency
				var perlin_value = noise_lite.get_noise_2d(sample_x, sample_y)

				noise_height += perlin_value * amplitude

				amplitude *= persistence
				frequency *= lacunarity

			
			current_row.append(noise_height)
			
			max_noise_height = max(noise_height, max_noise_height)
			min_noise_height = min(noise_height, min_noise_height)
		noise_map.append(current_row)
		#print(noise_map[y])
	
	for x in range(map_width):
		for y in range(map_height):
			noise_map[x][y] = inverse_lerp(min_noise_height, max_noise_height, noise_map[x][y])
	
	#for i in range(map_width):
		#print(noise_map[i])
	
	return noise_map
