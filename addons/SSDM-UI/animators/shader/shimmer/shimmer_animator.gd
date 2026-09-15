class_name SSDMUIShimmerAnimator
extends SSDMUIShaderAnimatorBase


func set_width(new_width: float) -> void:
	set_shader_parameter(SSDMUIGlobal.SHIMMER_WIDTH, new_width)
	
	
func set_brightness(new_brightness: float) -> void:
	set_shader_parameter(SSDMUIGlobal.SHIMMER_BRIGHTNESS, new_brightness)
