class_name SSDMUIControlPulseAnimator
extends SSDMUISingleControlShaderAnimatorBase

@export var min_alpha: float = 0.2 
	
		
func set_min_alpha(new_min_alpha: float) -> void:
	shader_material.set_shader_parameter(MIN_ALPHA, new_min_alpha)
	
		
func _init_shader_paramaters() -> void:
	super()
	set_min_alpha(min_alpha)
