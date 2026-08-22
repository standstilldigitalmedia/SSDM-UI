@abstract class_name SSDMUISingleControlShaderAnimatorBase
extends Control

const BG_COLOR: String = "bg_color"
const SHADER_PARAMETER: String = "shader_parameter/"
const SHADER_ENABLED: String = "shader_enabled"

@export var shader_material: ShaderMaterial


@abstract func _init_shader_paramaters() -> void
	
	
func set_background_color(new_background_color: Color) -> void:
	shader_material.set_shader_parameter(BG_COLOR, new_background_color)
	
	
func play() -> void:
	_enable_shader()
	
	
func kill() -> void:
	_disable_shader()
	
	
func _enable_shader() -> void:
	shader_material.set_shader_parameter(SHADER_ENABLED, 1.0)
	
	
func _disable_shader() -> void:
	shader_material.set_shader_parameter(SHADER_ENABLED, 0.0)
	
	
func _apply_shader() -> void:
	material = shader_material
	
	
func _create_timeout_timer(duration: float) -> void:
	if duration > 0.0:
		var timer: Timer = Timer.new()	
		timer.one_shot = true
		timer.wait_time = duration
		timer.timeout.connect(kill)
		add_child(timer)
		timer.start()
	
	
func _ready() -> void:
	_apply_shader()
	_init_shader_paramaters()
