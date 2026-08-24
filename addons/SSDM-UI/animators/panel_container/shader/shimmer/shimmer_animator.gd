class_name SSDMUIControlShimmerAnimator
extends SSDMUISingleControlShaderAnimatorBase

const WIDTH: String = "width"
const BRIGHTNESS: String = "brightness"

@export var width: float = 0.2 
@export var brightness: float = 0.5 


func set_width(new_width: float) -> void:
	shader_material.set_shader_parameter(WIDTH, new_width)
	
	
func set_brighness(new_brightness: float) -> void:
	shader_material.set_shader_parameter(BRIGHTNESS, new_brightness)

	
func _init_shader_paramaters() -> void:
	super()
	set_width(width)
	set_brighness(brightness)
