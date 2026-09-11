class_name SSDMUIControlDissolveAnimator
extends SSDMUISingleControlTweenedShaderAnimatorBase

@export var dissolve_speed: float = 1.0
@export var dissolve_mode: SSDMUIGlobal.Mode = SSDMUIGlobal.Mode.NOISE
@export var dissolve_spread: float = 0.1 

	
func set_mode(new_mode: SSDMUIGlobal.Mode) -> void:
	shader_material.set_shader_parameter(SSDMUIGlobal.DISSOLVE_MODE, new_mode)
	dissolve_mode = new_mode
	
	
func set_spread(new_spread: float) -> void:
	shader_material.set_shader_parameter(SSDMUIGlobal.DISSOLVE_SPREAD, new_spread)
	dissolve_spread = new_spread
	

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
	
	
func _tween_forward() -> void:
	shader_material.set_shader_parameter(SSDMUIGlobal.DISSOLVE_PROGRESS, 1.0)
	_main_tween.tween_property(shader_material, SSDMUIGlobal.SHADER_PARAMETER + SSDMUIGlobal.DISSOLVE_PROGRESS, 0.0, speed * float(1.0))	
	
	
func _tween_reverse() -> void:
	shader_material.set_shader_parameter(SSDMUIGlobal.DISSOLVE_PROGRESS, 0.0)
	_main_tween.tween_property(shader_material, SSDMUIGlobal.SHADER_PARAMETER + SSDMUIGlobal.DISSOLVE_PROGRESS, 1.0, speed)
