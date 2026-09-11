@abstract class_name SSDMUISingleControlTweenedShaderAnimatorBase
extends SSDMUISingleControlTweenAnimatorBase

@export var background_color: Color = Color(1,1,1,1)
@export var shader_material: ShaderMaterial


@abstract func set_speed(new_speed: float) -> void
@abstract func _enable_shader() -> void
@abstract func _disable_shader() -> void
	
	
func set_background_color(new_background_color: Color) -> void:
	shader_material.set_shader_parameter(SSDMUIGlobal.BACKGROUND_COLOR, new_background_color)
	background_color = new_background_color
	
	
func play() -> void:
	stop()
	_enable_shader()
	_create_play_tween()
	_tween_forward()
	await _main_tween.finished
	finished.emit()


func reverse() -> void:
	stop()
	_enable_shader()
	_create_reverse_tween()
	_tween_reverse()
	await _main_tween.finished
	finished.emit()
	
	
func stop() -> void:
	_disable_shader()
	super()
	
	
func _init_shader_paramaters() -> void:
	set_background_color(background_color)
	set_speed(speed)
	
	
func _apply_shader() -> void:
	material = shader_material
	
	
func _ready() -> void:
	_apply_shader()
	_init_shader_paramaters()
