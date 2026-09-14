@abstract class_name SSDMUIShaderAnimatorBase
extends RefCounted

var _animation_target: Control
var _shader_material: ShaderMaterial
var _timer: Timer
var _duration: float
var _speed_parameter_name: String
var _enable_parameter_name: String


func set_speed(new_speed: float) -> void:
	_set_shader_parameter(_speed_parameter_name, new_speed)


func set_background_color(new_background_color: Color) -> void:
	_set_shader_parameter(SSDMUIGlobal.BACKGROUND_COLOR, new_background_color)
	
	
func set_duration(new_duration: float) -> void:
	_duration = new_duration
	

func play() -> void:
	_enable_shader()
	_create_timeout_timer(_duration)
	
	
func stop() -> void:
	_disable_shader()
	_kill_timer()
	
	
func _enable_shader() -> void:
	_set_shader_parameter(_enable_parameter_name, 1.0)
	
	
func _disable_shader() -> void:
	_set_shader_parameter(_enable_parameter_name, 0.0)
	

func _set_shader_parameter(parameter: String, value: Variant) -> void:
	_shader_material.set_shader_parameter(parameter, value)
	
	
func _apply_shader() -> void:
	_animation_target.material = _shader_material
	
	
func _kill_timer() -> void:
	if _timer:
		if _timer.timeout.is_connected(stop):
			_timer.timeout.disconnect(stop)
		_timer.queue_free()
		
	
func _create_timeout_timer(duration: float) -> void:
	_kill_timer()
	if duration > 0.0:
		_timer = Timer.new()	
		_timer.one_shot = true
		_timer.wait_time = duration
		_timer.timeout.connect(stop)
		_animation_target.add_child(_timer)
		_timer.start()
		
		
func _init(
		animation_target: Control, 
		shader_material: ShaderMaterial, 
		speed_parameter_name: String, 
		enable_parameter_name: String,
		speed: float,
		background_color: Color,
		duration: float = 0.0
	) -> void:
	_animation_target = animation_target
	_shader_material = shader_material
	_speed_parameter_name = speed_parameter_name
	_enable_parameter_name = enable_parameter_name
	set_duration(duration)
	set_speed(speed)
	set_background_color(background_color)
	_apply_shader()
