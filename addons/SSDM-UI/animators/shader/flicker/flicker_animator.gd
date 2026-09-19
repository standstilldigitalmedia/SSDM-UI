class_name SSDMUIFlickerAnimator
extends SSDMUIShaderAnimatorBase


func set_min_alpha(new_min: float) -> void:
	_set_shader_parameter(SSDMUIGlobal.FLICKER_MIN_ALPHA, new_min)
