class_name SSDMFlickerAnimator
extends SSDMPanelShaderAnimatorBase

@export_group("Flicker")
@export var flicker_speed: float = 10.0  ## Flicker updates per second.
@export var flicker_min: float = 0.3  ## Minimum alpha during a dark flicker frame.

@export_group("Background Color")
@export var background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.


func set_shader_paramaters() -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.BG_COLOR, background_color)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.FLICKER_SPEED, flicker_speed)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.FLICKER_MIN, flicker_min)
