extends MeshInstance3D
class_name MeshData

var vertices = PackedVector3Array()
var normals = PackedVector3Array()
var colors = PackedVector3Array()
var triangles : PackedInt32Array
var triangle_index : int
var uvs : PackedVector2Array
var surface_array : Array = []
@export var mesh_width : int = 256
@export var mesh_height : int = 256


func _init():
	vertices.resize(mesh_width * mesh_height)
	triangles.resize((mesh_width-1) * (mesh_height-1) * 6)
	uvs.resize(mesh_width *mesh_height)
	surface_array.resize(Mesh.ARRAY_MAX)
	normals.resize(mesh_width * mesh_height)
	triangle_index = 0
	
	
	
func add_triangle(a, b, c):
	triangles[triangle_index] = a
	triangles[triangle_index+1] = b
	triangles[triangle_index+2] = c
	triangle_index += 3
	
func commit_mesh():
	surface_array[Mesh.ARRAY_VERTEX] = vertices
	surface_array[Mesh.ARRAY_NORMAL] = normals
	surface_array[Mesh.ARRAY_TEX_UV2] = uvs
	surface_array[Mesh.ARRAY_INDEX] = triangles
	print("OH NO! ", mesh==null)
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)

func generate_mesh(height_map):
	var new_mesh_data = ProceduralMeshGenerator.generate_terrain_mesh(height_map)
	vertices = new_mesh_data.vertices
	normals = new_mesh_data.normals
	uvs = new_mesh_data.uvs
	triangles = new_mesh_data.triangles
	
	commit_mesh()
	
