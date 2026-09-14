class_name SSDMUIControlPulseAnimator
extends SSDMUISingleControlShaderAnimatorBase
	
		
func set_min_alpha(new_min_alpha: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.PULSE_MIN_ALPHA, new_min_alpha)
