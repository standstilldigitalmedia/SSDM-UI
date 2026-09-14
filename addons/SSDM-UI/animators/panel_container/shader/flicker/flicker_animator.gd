class_name SSDMUIControlFlickerAnimator
extends SSDMUISingleControlShaderAnimatorBase


func set_min_alpha(new_min: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.FLICKER_MIN_ALPHA, new_min)
