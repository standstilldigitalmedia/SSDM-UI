@abstract class_name SSDMUISingleControlTweenedShaderAnimatorBase
extends SSDMUISingleControlTweenAnimatorBase

@export var background_color: Color = Color(1,1,1,1)
@export var shader_material: ShaderMaterial


func set_speed(new_speed: float) -> void:
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.SPEED, new_speed)
	speed = new_speed
	
	
func set_background_color(new_background_color: Color) -> void:
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.BACKGROUND_COLOR, new_background_color)
	
	
func play() -> void:
	stop()
	_enable_shader()
	_create_play_tween()
	_tween_forward()
	await _main_tween.finished
	finished.emit()


func reverse() -> void:
	stop()
	_create_reverse_tween()
	_enable_shader()
	_tween_reverse()
	await _main_tween.finished
	finished.emit()
	
	
func stop() -> void:
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
