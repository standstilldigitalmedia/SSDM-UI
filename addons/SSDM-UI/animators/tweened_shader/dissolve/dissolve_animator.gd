class_name SSDMUIDissolveAnimator
extends SSDMUITweenedShaderAnimatorBase


func set_mode(new_mode: SSDMUIGlobal.Mode) -> void:
	shader_animator._set_shader_parameter(SSDMUIGlobal.DISSOLVE_MODE, new_mode)
	
	
func set_spread(new_spread: float) -> void:
	shader_animator._set_shader_parameter(SSDMUIGlobal.DISSOLVE_SPREAD, new_spread)
	
	
func play() -> void:
	shader_animator._set_shader_parameter(SSDMUIGlobal.DISSOLVE_PROGRESS, 1.0)
	super()
	
	
func reverse() -> void:
	shader_animator._set_shader_parameter(SSDMUIGlobal.DISSOLVE_PROGRESS, 0.0)
	super()
