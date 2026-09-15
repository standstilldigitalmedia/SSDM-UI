class_name SSDMUIPulseAnimator
extends SSDMUIShaderAnimatorBase
	
		
func set_min_alpha(new_min_alpha: float) -> void:
	set_shader_parameter(SSDMUIGlobal.PULSE_MIN_ALPHA, new_min_alpha)
