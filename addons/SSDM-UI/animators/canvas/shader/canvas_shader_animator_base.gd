class_name SSDMCanvasShaderAnimatorBase
extends Control


@export var shader_material: ShaderMaterial

var original_material: Material
var original_style_box: StyleBox


func apply_shader() -> void:
	if not original_material and material:
		original_material = material
	material = shader_material
	
	
func _ready() -> void:
	apply_shader()
	original_style_box = get_theme_stylebox("panel").duplicate()
