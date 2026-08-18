class_name SSDMPanelShaderAnimatorBase
extends Control


@export var shader_material: ShaderMaterial

var original_material: Material
var original_style_box: StyleBox


func set_shader_paramaters() -> void:
	pass

func apply_shader() -> void:
	if not original_material and material:
		original_material = material
	material = shader_material
	
	
func enable_shader() -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.SHADER_ENABLED, 1.0)
	
	
func disable_shader() -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.SHADER_ENABLED, 0.0)
	

func play() -> void:
	enable_shader()
	
	
func reverse() -> void:
	enable_shader()
	
	
func kill() -> void:
	disable_shader()
	
	
func _ready() -> void:
	apply_shader()
	original_style_box = get_theme_stylebox("panel").duplicate()
