class_name SSDMShimmerAnimator
extends SSDMPanelShaderAnimatorBase

@export var shimmer_speed: float = 2.0  ## How fast the shimmer band moves.
@export var shimmer_width: float = 0.2  ## Fractional width of the shimmer band (0-1).
@export var shimmer_brightness: float = 0.5  ## Additional brightness inside the shimmer band.
@export var shimmer_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.


func set_speed(new_speed: float) -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.SHIMMER_SPEED, new_speed)
	
	
func set_width(new_width: float) -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.SHIMMER_WIDTH, new_width)
	
	
func set_brighness(new_brightness: float) -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.SHIMMER_BRIGHTNESS, new_brightness)


func set_shader_paramaters() -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.BG_COLOR, shimmer_background_color)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.SHIMMER_SPEED, shimmer_speed)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.SHIMMER_WIDTH, shimmer_width)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.SHIMMER_BRIGHTNESS, shimmer_brightness)
