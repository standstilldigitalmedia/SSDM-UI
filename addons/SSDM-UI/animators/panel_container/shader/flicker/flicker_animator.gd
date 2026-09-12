class_name SSDMUIControlFlickerAnimator
extends SSDMUISingleControlShaderAnimatorBase

var flicker_min_alpha: float = 0.3
var flicker_speed: float = 1.0
var flicker_duration: float = 0.0


func set_speed(new_speed: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.FLICKER_SPEED, new_speed)
	flicker_speed = new_speed
	
	
func set_duration(new_duration: float) -> void:
	flicker_duration = new_duration
	
	
func play() -> void:
	super()
	_create_timeout_timer(flicker_duration)
	
	
func _enable_shader() -> void:
	_set_shader_parameter(SSDMUIGlobal.FLICKER_ENABLED, 1.0)
	
	
func _disable_shader() -> void:
	_set_shader_parameter(SSDMUIGlobal.FLICKER_ENABLED, 0.0)
	
	
func set_min_alpha(new_min: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.FLICKER_MIN_ALPHA, new_min)
	flicker_min_alpha = new_min
	
	
func _init_shader_paramaters() -> void:
	super()
	set_min_alpha(flicker_min_alpha)
	set_speed(flicker_speed)
