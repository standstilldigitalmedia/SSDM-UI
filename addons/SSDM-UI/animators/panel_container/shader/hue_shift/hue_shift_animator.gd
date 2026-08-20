class_name SSDMUIControlHueShiftAnimator
extends SSDMUISingleControlShaderAnimatorBase

const HUE_SHIFT_ENABLED: String = "hue_shift_enabled"
const HUE_SHIFT_SPEED: String = "hue_shift_speed"

@export var hue_shift_speed: float = 1.0  ## Hue rotation speed in full cycles per second.
@export var hue_shift_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.


func set_speed(new_speed: float) -> void:
	shader_material.set_shader_parameter(HUE_SHIFT_SPEED, new_speed)
	
	
func _init_shader_paramaters() -> void:
	set_background_color(hue_shift_background_color)
	set_speed(hue_shift_speed)
