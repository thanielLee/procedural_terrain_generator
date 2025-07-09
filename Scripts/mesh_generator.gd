
static func generate_terrain_mesh(height_map):
	var width = height_map[0].size()
	var height = height_map.size()
	var top_left_x = (width-1)/(-2.0)
	var top_left_z = (height-1)/(-2.0)
	
	var vertex_index = 0
	var mesh_data = MeshData.new(width, height)
	
	for y in range(height):
		for x in range(width):
			mesh_data.vertices[vertex_index] = Vector3(top_left_x + x, height_map[y][x], top_left_z - y)
			mesh_data.uvs[vertex_index] = Vector2(x/(width as float), y/(height as float))
			
			if x < width - 1 and y < height - 1:
				mesh_data.add_triangle(vertex_index, vertex_index+width+1, vertex_index+width)
				mesh_data.add_triangle(vertex_index, vertex_index+1, vertex_index+width+1)
