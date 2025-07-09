class_name NoiseGenerator


static func generate_noise_map(map_width, map_height, scale, noise_lite, seed, octaves, persistence, lacunarity, offset):
	var noise_map = []
	var octave_offsets = []
	var rng = RandomNumberGenerator.new()
	rng.seed = seed
	
	for i in range(octaves):
		var offset_x = rng.randf_range(-100000, 100000) + offset.x
		var offset_y = rng.randf_range(-100000, 100000) + offset.y
		octave_offsets.append(Vector2(offset_x, offset_y))
		
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
	
	var half_width = map_width/2
	var half_height = map_height/2

	for y in range(map_height):
		var current_row = []
		for x in range(map_width):
			
			var amplitude = 1
			var frequency = 1
			var noise_height = 0


			for i in range(octaves):
				var sample_x = (x-half_width) / scale * frequency + octave_offsets[i].x
				var sample_y = (y-half_height) / scale * frequency + octave_offsets[i].y
				var perlin_value = noise_lite.get_noise_2d(sample_x, sample_y)

				noise_height += perlin_value * amplitude

				amplitude *= persistence
				frequency *= lacunarity

			
			current_row.append(noise_height)
			
			max_noise_height = max(noise_height, max_noise_height)
			min_noise_height = min(noise_height, min_noise_height)
		noise_map.append(current_row)
		#print(noise_map[y])
		
	for y in range(map_height):
		for x in range(map_width):
			noise_map[y][x] = inverse_lerp(min_noise_height, max_noise_height, noise_map[y][x])
	
	#for i in range(map_width):
		#print(noise_map[i])
	
	return noise_map
