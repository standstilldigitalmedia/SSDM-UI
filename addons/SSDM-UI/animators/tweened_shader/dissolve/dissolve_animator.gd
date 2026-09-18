class_name SSDMUIDissolveAnimator
extends SSDMUITweenedShaderAnimatorBase


func set_mode(new_mode: SSDMUIGlobal.Mode) -> void:
	shader_animator.set_shader_parameter(SSDMUIGlobal.DISSOLVE_MODE, new_mode)
	
	
func set_spread(new_spread: float) -> void:
	shader_animator.set_shader_parameter(SSDMUIGlobal.DISSOLVE_SPREAD, new_spread)
	
	
func play() -> void:
	shader_animator.set_shader_parameter(SSDMUIGlobal.DISSOLVE_PROGRESS, 1.0)
	super()
	
	
func reverse() -> void:
	shader_animator.set_shader_parameter(SSDMUIGlobal.DISSOLVE_PROGRESS, 0.0)
	super()
	
	
func _init(
		animation_target: Variant,
		animation_parent: Control, 
		shader_material: ShaderMaterial, 
		speed: float,
		background_color: Color,
		tween_target: Control,
		transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None,
		ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None,
		ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None,
		duration: float = 0.0,
	) -> void:
		shader_animator = SSDMUIShaderAnimatorBase.new(animation_parent, shader_material, "", SSDMUIGlobal.DISSOLVE_ENABLED, 0, background_color, duration)
		tween_animator = SSDMUITransformAnimatorBase.new(shader_material, animation_parent, SSDMUIGlobal.SHADER_PARAMETER + SSDMUIGlobal.DISSOLVE_PROGRESS, speed, 1, 0, transition_type, ease_type_play, ease_type_reverse)
	

"""@export var dissolve_speed: float = 1.0
@export var dissolve_mode: SSDMUIGlobal.Mode = SSDMUIGlobal.Mode.NOISE
@export var dissolve_spread: float = 0.1 

	

	

func set_speed(new_speed: float) -> void:
	pass
	
	
func _enable_shader() -> void:
	shader_material.set_shader_parameter(SSDMUIGlobal.DISSOLVE_ENABLED, 1.0)
	
	
func _disable_shader() -> void:
	shader_material.set_shader_parameter(SSDMUIGlobal.DISSOLVE_ENABLED, 0.0)


func _init_shader_paramaters() -> void:
	super()
	set_mode(dissolve_mode)
	set_spread(dissolve_spread)
	
	

"""
