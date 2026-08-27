class_name SSDMUIControlFlickerAnimator
extends SSDMUISingleControlShaderAnimatorBase

@export var min_alpha: float = 0.3 	
	
	
func set_min_alpha(new_min: float) -> void:
	shader_material.set_shader_parameter(MIN_ALPHA, new_min)
	
	
func _init_shader_paramaters() -> void:
	super()
	set_min_alpha(min_alpha)
	set_speed(10.0)
