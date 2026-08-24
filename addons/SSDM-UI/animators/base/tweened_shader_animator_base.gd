@abstract class_name SSDMUISingleControlTweenedShaderAnimatorBase
extends SSDMUISingleControlTweenAnimatorBase

@export var duration: float = 0.0 
@export var background_color: Color = Color(1,1,1,1)
@export var shader_material: ShaderMaterial

	
func set_duration(new_duration: float) -> void:
	duration = new_duration
	
	
func set_background_color(new_background_color: Color) -> void:
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.BG_COLOR, new_background_color)
	
	
func play() -> void:
	kill()
	_enable_shader()
	_create_timeout_timer(duration)	
	_init_tween_forward()
	_create_open_tween()
	_tween_forward()
	await main_tween.finished
	finished.emit()


func reverse() -> void:
	kill()
	_create_close_tween()
	_enable_shader()
	_create_timeout_timer(duration)	
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
