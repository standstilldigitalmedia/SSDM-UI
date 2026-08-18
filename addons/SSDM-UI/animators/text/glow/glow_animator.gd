class_name SSDMGlowAnimator
extends SSDMPanelShaderAnimatorBase

@export_group("Glow")
@export var glow_intensity: float = 1.0  ## Glow brightness multiplier. Higher = brighter.
@export var glow_color: Color = Color.WHITE  ## Tint color added to the glow.

@export_group("Background Color")
@export var background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.

func set_shader_paramaters() -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.BG_COLOR, background_color)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.GLOW_INTENSITY, glow_intensity)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.GLOW_COLOR, glow_color)
	
	
func play() -> void:
	enable_shader()
	
	
func reverse() -> void:
	enable_shader()
	
	
func kill() -> void:
	disable_shader()
	
	
func _ready() -> void:
	super()
	set_shader_paramaters()
