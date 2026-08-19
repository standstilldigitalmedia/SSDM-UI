class_name SSDMUIControlShimmerAnimator
extends SSDMUISingleControlShaderAnimatorBase

const SHIMMER_ENABLED: String = "shimmer_enabled"
const SHIMMER_SPEED: String = "shimmer_speed"
const SHIMMER_WIDTH: String = "shimmer_width"
const SHIMMER_BRIGHTNESS: String = "shimmer_brightness"

@export var shimmer_speed: float = 2.0  ## How fast the shimmer band moves.
@export var shimmer_width: float = 0.2  ## Fractional width of the shimmer band (0-1).
@export var shimmer_brightness: float = 0.5  ## Additional brightness inside the shimmer band.
@export var shimmer_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.


func set_speed(new_speed: float) -> void:
	shader_material.set_shader_parameter(SHIMMER_SPEED, new_speed)
	
	
func set_width(new_width: float) -> void:
	shader_material.set_shader_parameter(SHIMMER_WIDTH, new_width)
	
	
func set_brighness(new_brightness: float) -> void:
	shader_material.set_shader_parameter(SHIMMER_BRIGHTNESS, new_brightness)


func set_shader_paramaters() -> void:
	set_background_color(shimmer_background_color)
	set_speed(shimmer_speed)
	set_width(shimmer_width)
	set_brighness(shimmer_brightness)
