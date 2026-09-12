class_name SSDMUIControlPulseAnimator
extends SSDMUISingleControlShaderAnimatorBase

var pulse_speed: float = 1.0
var pulse_duration: float = 0.0
var pulse_min_alpha: float = 0.2


func set_speed(new_speed: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.PULSE_SPEED, new_speed)
	pulse_speed = new_speed
	
	
func set_duration(new_duration: float) -> void:
	pulse_duration = new_duration
	
	
func play() -> void:
	super()
	_create_timeout_timer(pulse_duration)
	
	
func _enable_shader() -> void:
	_set_shader_parameter(SSDMUIGlobal.PULSE_ENABLED, 1.0)
	
	
func _disable_shader() -> void:
	_set_shader_parameter(SSDMUIGlobal.PULSE_ENABLED, 0.0)
	
		
func set_min_alpha(new_min_alpha: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.PULSE_MIN_ALPHA, new_min_alpha)
	pulse_min_alpha = new_min_alpha
	
		
func _init_shader_paramaters() -> void:
	super()
	set_speed(10.0)
	set_min_alpha(pulse_min_alpha)
