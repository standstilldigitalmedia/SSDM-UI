class_name SSDMPulseAnimator
extends SSDMPanelShaderAnimatorBase

@export var pulse_speed: float = 5.0  ## Cycles per second for the pulse.
@export var pulse_min_alpha: float = 0.2  ## Minimum alpha at the bottom of each pulse cycle.
@export var pulse_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.


func set_speed(new_speed: float) -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.PULSE_SPEED, new_speed)
	
	
func set_min_alpha(new_min_alpha: float) -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.PULSE_MIN_ALPHA, new_min_alpha)
	
	
func set_shader_paramaters() -> void:
	set_background_color(pulse_background_color)
	set_speed(pulse_speed)
	set_min_alpha(pulse_min_alpha)
