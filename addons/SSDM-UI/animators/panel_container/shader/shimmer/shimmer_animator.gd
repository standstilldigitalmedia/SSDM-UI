class_name SSDMUIControlShimmerAnimator
extends SSDMUISingleControlShaderAnimatorBase

@export var shimmer_speed: float = 1.0
@export var shimmer_duration: float = 0.0
@export var shimmer_width: float = 0.2 
@export var shimmer_brightness: float = 0.5 


func set_width(new_width: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.SHIMMER_WIDTH, new_width)
	shimmer_width = new_width
	
	
func set_brightness(new_brightness: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.SHIMMER_BRIGHTNESS, new_brightness)
	shimmer_brightness = new_brightness
	
	
func set_speed(new_speed: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.SHIMMER_SPEED, new_speed)
	shimmer_speed = new_speed
	
	
func set_duration(new_duration: float) -> void:
	shimmer_duration = new_duration
	
	
func play() -> void:
	super()
	_create_timeout_timer(shimmer_duration)
	
	
func _enable_shader() -> void:
	_set_shader_parameter(SSDMUIGlobal.SHIMMER_ENABLED, 1.0)
	
	
func _disable_shader() -> void:
	_set_shader_parameter(SSDMUIGlobal.SHIMMER_ENABLED, 0.0)

	
func _init_shader_paramaters() -> void:
	super()
	set_width(shimmer_width)
	set_brightness(shimmer_brightness)
