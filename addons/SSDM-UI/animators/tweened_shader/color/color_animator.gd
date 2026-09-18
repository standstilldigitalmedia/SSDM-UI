class_name SSDMUIColorAnimator
extends SSDMUITweenedShaderAnimatorBase


func _init(
		animation_target: Variant,
		animation_parent: Control, 
		shader_material: ShaderMaterial, 
		speed: float,
		background_color: Color,
		to_color: Color,
		tween_target: Control,
		transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None,
		ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None,
		ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None,
		duration: float = 0.0
	) -> void:
		shader_animator = SSDMUIShaderAnimatorBase.new(animation_parent, shader_material, "", SSDMUIGlobal.COLOR_ENABLED, 0, background_color, duration)
		tween_animator = SSDMUITransformAnimatorBase.new(shader_material, animation_parent, SSDMUIGlobal.SHADER_PARAMETER + SSDMUIGlobal.BACKGROUND_COLOR, speed, background_color, to_color, transition_type, ease_type_play, ease_type_reverse)

"""@export var color_speed: float = 1.0
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
"""
