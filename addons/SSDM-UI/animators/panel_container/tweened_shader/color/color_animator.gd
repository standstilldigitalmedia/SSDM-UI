class_name SSDMUIControlColorAnimator
extends SSDMUISingleControlTweenedShaderAnimatorBase

@export var color_speed: float = 1.0
@export var to_color: Color = Color(0,0,0,1)


func set_to_color(new_color: Color) -> void:
	to_color = new_color
	
	
func set_speed(new_speed: float) -> void:
	color_speed = new_speed
	
	
func _enable_shader() -> void:
	pass
	
	
func _disable_shader() -> void:
	pass
	
	
func _tween_forward() -> void:
	_main_tween.tween_property(shader_material, SSDMUIGlobal.SHADER_PARAMETER + SSDMUIGlobal.BACKGROUND_COLOR, to_color, speed)	
	
	
func _tween_reverse() -> void:
	_main_tween.tween_property(shader_material, SSDMUIGlobal.SHADER_PARAMETER + SSDMUIGlobal.BACKGROUND_COLOR, background_color, speed)	
