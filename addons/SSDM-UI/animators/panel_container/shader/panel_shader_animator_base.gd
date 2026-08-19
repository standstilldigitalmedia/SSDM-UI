@abstract class_name SSDMUISingleControlShaderAnimatorBase
extends Control

const BG_COLOR: String = "bg_color"
const SHADER_PARAMETER: String = "shader_parameter/"
const SHADER_ENABLED: String = "shader_enabled"

@export var shader_material: ShaderMaterial


@abstract func set_shader_paramaters() -> void
	
	
func set_background_color(new_background_color: Color) -> void:
	shader_material.set_shader_parameter(BG_COLOR, new_background_color)
	
	
func enable_shader() -> void:
	shader_material.set_shader_parameter(SHADER_ENABLED, 1.0)
	
	
func disable_shader() -> void:
	shader_material.set_shader_parameter(SHADER_ENABLED, 0.0)
	

func play() -> void:
	enable_shader()
	
	
func kill() -> void:
	disable_shader()
	
	
func _apply_shader() -> void:
	material = shader_material
	
	
func _ready() -> void:
	_apply_shader()
	set_shader_paramaters()
