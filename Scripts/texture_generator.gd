class_name TextureGenerator
static func texture_from_color_map(color_map, width, height):
	var image = Image.create_empty(width, height, false, Image.Format.FORMAT_RGB8)
	
	for y in range(height):
		for x in range(width):
			image.set_pixel(x, y, color_map[y][x])
			
	var new_texture = ImageTexture.create_from_image(image)
	return new_texture

static func texture_from_height_map(height_map):
	var width = height_map[0].size()
	var height = height_map.size()
	var noise_image = Image.create_empty(width, height, false, Image.Format.FORMAT_RGB8)
	
	print(height, " ", width)
	for y in range(height):
		for x in range(width):
			#print(y, " ", x)
			noise_image.set_pixel(x, y, Color.BLACK.lerp(Color.WHITE, height_map[y][x]))
			
	return ImageTexture.create_from_image(noise_image)
