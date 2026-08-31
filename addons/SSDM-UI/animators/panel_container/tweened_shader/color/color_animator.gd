class_name SSDMUIControlColorAnimator
extends SSDMUISingleControlTweenedShaderAnimatorBase

const BG_COLOR: String = "bg_color"

@export var to_color: Color = Color(0,0,0,1)


func set_to_color(new_color: Color) -> void:
	to_color = new_color
	
	
func _init_shader_paramaters() -> void:
	super()
	
	
func _tween_forward() -> void:
	_main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + SSDMUISingleControlShaderAnimatorBase.BACKGROUND_COLOR, to_color, speed)	
	
	
func _tween_reverse() -> void:
	_main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + SSDMUISingleControlShaderAnimatorBase.BACKGROUND_COLOR, background_color, speed)	
