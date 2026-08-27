class_name SSDMUIControlDissolveAnimator
extends SSDMUISingleControlTweenedShaderAnimatorBase

const MODE: String = "mode"
const SPREAD: String = "spread"

enum Mode 
{ 
	UV_SWEEP, 
	NOISE, 
	RADIAL 
}


@export var mode: Mode = Mode.NOISE
@export var spread: float = 0.1 

	
	
func set_mode(new_mode: Mode) -> void:
	shader_material.set_shader_parameter(MODE, new_mode)
	
	
func set_spread(new_spread: float) -> void:
	shader_material.set_shader_parameter(SPREAD, new_spread)


func _init_tween_forward() -> void:
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.PROGRESS, 1.0)
		
	
func _init_tween_reverse() -> void:
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.PROGRESS, 0.0)


func _init_shader_paramaters() -> void:
	set_background_color(background_color)
	set_mode(mode)
	set_spread(spread)
	
	
func _tween_reverse() -> void:
	main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + SSDMUISingleControlShaderAnimatorBase.PROGRESS, 1.0, speed)
	
	
func _tween_forward() -> void:
	var current_progress = shader_material.get_shader_parameter(SSDMUISingleControlShaderAnimatorBase.PROGRESS)
	if current_progress == null:
		current_progress = 1.0
	main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + SSDMUISingleControlShaderAnimatorBase.PROGRESS, 0.0, speed * float(current_progress))	
