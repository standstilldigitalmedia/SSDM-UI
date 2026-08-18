@abstract class_name SSDMPanelShaderAnimatorBase
extends Control

@export var shader_material: ShaderMaterial

var _original_material: Material
var _original_style_box: StyleBox


@abstract func set_shader_paramaters() -> void
	
	
func set_background_color(new_background_color: Color) -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.BG_COLOR, new_background_color)
	
	
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
	
	
func _apply_shader() -> void:
	if not _original_material and material:
		_original_material = material
	material = shader_material
	
	
func _ready() -> void:
	_apply_shader()
	_original_style_box = get_theme_stylebox("panel").duplicate()
	set_shader_paramaters()
