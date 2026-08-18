class_name SSDMHueShiftAnimator
extends SSDMPanelShaderAnimatorBase

@export var hue_shift_speed: float = 1.0  ## Hue rotation speed in full cycles per second.
@export var hue_shift_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.


func set_shader_paramaters() -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.BG_COLOR, hue_shift_background_color)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.HUE_SHIFT_SPEED, hue_shift_speed)
