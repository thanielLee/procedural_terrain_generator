extends Resource
class_name MeshData

var vertices : PackedVector3Array
var triangles : PackedInt32Array
var triangle_index : int
var uvs : PackedVector2Array

func _init(mesh_width, mesh_height):
	vertices.resize(mesh_width * mesh_height)
	triangles.resize((mesh_width-1) * (mesh_height-1) * 6)
	uvs.resize(mesh_width *mesh_height)
	triangle_index = 0
	
func add_triangle(a, b, c):
	triangles[triangle_index] = a
	triangles[triangle_index+1] = b
	triangles[triangle_index+2] = c
	triangle_index += 3
	
	
func create_mesh():
	var new_mesh = Mesh.new()
	
