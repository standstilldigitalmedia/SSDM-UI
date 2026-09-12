class_name SSDMUIControlHueShiftAnimator
extends SSDMUISingleControlShaderAnimatorBase

var hue_shift_speed: float = 1.0
var hue_shift_duration: float = 0.0


func set_speed(new_speed: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.HUE_SHIFT_SPEED, new_speed)
	hue_shift_speed = new_speed
	
	
func set_duration(new_duration: float) -> void:
	hue_shift_duration = new_duration
	
	
func play() -> void:
	super()
	_create_timeout_timer(hue_shift_duration)
	
	
func _enable_shader() -> void:
	_set_shader_parameter(SSDMUIGlobal.HUE_SHIFT_ENABLED, 1.0)
	
	
func _disable_shader() -> void:
	_set_shader_parameter(SSDMUIGlobal.HUE_SHIFT_ENABLED, 0.0)
