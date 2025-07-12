class_name ProceduralMeshGenerator
static func generate_terrain_mesh(height_map):
	var width = height_map[0].size()
	var height = height_map.size()
	var top_left_x = (width-1)/(-2.0)
	var top_left_z = (height-1)/(-2.0)
	
	var vertex_index = 0
	var mesh_data = MeshData.new()
	
	
	for y in range(height):
		for x in range(width):
			mesh_data.vertices[vertex_index] = Vector3(top_left_x + x, height_map[y][x], top_left_z - y)
			mesh_data.uvs[vertex_index] = Vector2(x/(width as float), y/(height as float))
			
			
			if x < width - 1 and y < height - 1:
				mesh_data.add_triangle(vertex_index, vertex_index+width+1, vertex_index+width)
				mesh_data.add_triangle(vertex_index, vertex_index+1, vertex_index+width+1)
			
			vertex_index += 1
	
	vertex_index = 0
	for y in range(height):
		for x in range(width):
			if x == 0 or x == width-1 or y == 0 or y == width-1:
				mesh_data.normals[vertex_index] = Vector3(0, 1, 0)
			else:
				var v1 = mesh_data.vertices[vertex_index]
				var v2 = mesh_data.vertices[vertex_index+width]
				var v3 = mesh_data.vertices[vertex_index+1]
				var v4 = mesh_data.vertices[vertex_index+width+1]
				
				var vec1 = v2 - v1
				var vec2 = v4 - v1
				var vec3 = v3 - v1
				
				var normal1 = vec1.cross(vec2).normalized()
				var normal2 = vec3.cross(vec2).normalized()
				
				mesh_data.normals[vertex_index] = (normal1 + normal2) / 2
			vertex_index += 1
	
	return mesh_data
