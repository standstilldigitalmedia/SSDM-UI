class_name SSDMUIControlColorAnimator
extends SSDMUISingleControlTweenedShaderAnimatorBase

const BG_COLOR: String = "bg_color"

@export var to_color: Color = Color(0,0,0,1)


func _init_tween_forward() -> void:
	pass
	
	
func _init_tween_reverse() -> void:
	pass
	
	
func _init_shader_paramaters() -> void:
	pass
	
	
func _tween_forward() -> void:
	main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + SSDMUISingleControlShaderAnimatorBase.BG_COLOR, to_color, speed)	
	
	
func _tween_reverse() -> void:
	main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + SSDMUISingleControlShaderAnimatorBase.BG_COLOR, background_color, speed)	
