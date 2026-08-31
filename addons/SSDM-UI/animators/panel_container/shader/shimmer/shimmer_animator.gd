class_name SSDMUIControlShimmerAnimator
extends SSDMUISingleControlShaderAnimatorBase

const SHIMMER_WIDTH: String = "width"
const SHIMMER_BRIGHTNESS: String = "brightness"

@export var width: float = 0.2 
@export var brightness: float = 0.5 


func set_width(new_width: float) -> void:
	shader_material.set_shader_parameter(SHIMMER_WIDTH, new_width)
	
	
func set_brightness(new_brightness: float) -> void:
	shader_material.set_shader_parameter(SHIMMER_BRIGHTNESS, new_brightness)

	
func _init_shader_paramaters() -> void:
	super()
	set_width(width)
	set_brightness(brightness)
