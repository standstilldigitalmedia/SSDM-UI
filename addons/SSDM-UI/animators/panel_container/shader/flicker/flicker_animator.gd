class_name SSDMUIControlFlickerAnimator
extends SSDMUISingleControlShaderAnimatorBase

const FLICKER_ENABLED: String = "flicker_enabled"
const FLICKER_SPEED: String = "flicker_speed"
const FLICKER_MIN: String = "flicker_min"

@export var flicker_speed: float = 10.0  ## Flicker updates per second.
@export var flicker_min_alpha: float = 0.3  ## Minimum alpha during a dark flicker frame.
@export var flicker_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.


func set_speed(new_speed: float) -> void:
	shader_material.set_shader_parameter(FLICKER_SPEED, new_speed)
	
	
func set_min_alpha(new_min: float) -> void:
	shader_material.set_shader_parameter(FLICKER_MIN, new_min)
	

func set_shader_paramaters() -> void:
	set_background_color(flicker_background_color)
	set_speed(flicker_speed)
	set_min_alpha(flicker_min_alpha)
