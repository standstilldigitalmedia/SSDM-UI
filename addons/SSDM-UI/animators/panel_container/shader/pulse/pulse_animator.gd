class_name SSDMPulseAnimator
extends SSDMPanelShaderAnimatorBase

@export_group("Pulse")
@export var pulse_speed: float = 2.0  ## Cycles per second for the pulse.
@export var pulse_min_alpha: float = 0.2  ## Minimum alpha at the bottom of each pulse cycle.

@export_group("Background Color")
@export var background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.


func set_shader_paramaters() -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.BG_COLOR, background_color)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.PULSE_SPEED, pulse_speed)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.PULSE_MIN_ALPHA, pulse_min_alpha)
