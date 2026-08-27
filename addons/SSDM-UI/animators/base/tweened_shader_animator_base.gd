@abstract class_name SSDMUISingleControlTweenedShaderAnimatorBase
extends SSDMUISingleControlTweenAnimatorBase

@export var background_color: Color = Color(1,1,1,1)
@export var shader_material: ShaderMaterial


func set_speed(new_speed: float) -> void:
	speed = new_speed
	
	
func set_background_color(new_background_color: Color) -> void:
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.BG_COLOR, new_background_color)
	
	
func play() -> void:
	kill()
	_enable_shader()
	_init_tween_forward()
	_create_open_tween()
	_tween_forward()
	await main_tween.finished
	finished.emit()


func reverse() -> void:
	kill()
	_create_close_tween()
	_enable_shader()
	_init_tween_reverse()
	_tween_reverse()
	await main_tween.finished
	finished.emit()
	
	
func kill() -> void:
	_disable_shader()
	super()
	
	
func _init_shader_paramaters() -> void:
	set_background_color(background_color)
	set_speed(speed)
	
	
func _enable_shader() -> void:
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.SHADER_ENABLED, 1.0)
	
	
func _disable_shader() -> void:
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.SHADER_ENABLED, 0.0)
	
	
func _apply_shader() -> void:
	material = shader_material
	
	
func _ready() -> void:
	_apply_shader()
	_init_shader_paramaters()
