class_name SSDMUIControlDissolveAnimator
extends SSDMUISingleControlTweenedShaderAnimatorBase

const MODE: String = "mode"
const PROGRESS: String = "progress"
const SPREAD: String = "spread"

enum Mode 
{ 
	UV_SWEEP, 
	NOISE, 
	RADIAL 
}


@export var mode: Mode = Mode.NOISE
@export var spread: float = 0.1 

	
	
func set_mode(new_mode: Mode) -> void:
	shader_material.set_shader_parameter(MODE, new_mode)
	
	
func set_spread(new_spread: float) -> void:
	shader_material.set_shader_parameter(SPREAD, new_spread)
	
	
func set_ease_type_open(new_ease_type_open: Tween.EaseType) -> void:
	ease_type_open = new_ease_type_open
	
	
func set_transition_type(new_transition_type: Tween.TransitionType) -> void:
	transition_type = new_transition_type
	
	
func play() -> void:
	_create_open_tween()
	_enable_shader()
	_init_tween_forward()
	_tween_forward()
	await main_tween.finished
	finished.emit()
	

func reverse() -> void:
	_create_close_tween()
	_enable_shader()
	_init_tween_reverse()
	_tween_reverse()
	await main_tween.finished
	_disable_shader()
	finished.emit()
	
		
func kill() -> void:
	if main_tween:
		main_tween.kill()
	_disable_shader()


func _init_tween_forward() -> void:
	shader_material.set_shader_parameter(PROGRESS, 1.0)
		
	
func _init_tween_reverse() -> void:
	shader_material.set_shader_parameter(PROGRESS, 0.0)


func _init_shader_paramaters() -> void:
	set_background_color(background_color)
	set_mode(mode)
	set_spread(spread)
	

func _create_open_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_trans(transition_type)
	main_tween.set_ease(ease_type_open)
	
		
func _create_close_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_trans(transition_type)
	main_tween.set_ease(ease_type_close)
	
	
func _tween_reverse() -> void:
	main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + PROGRESS, 1.0, speed)
	
	
func _tween_forward() -> void:
	var current_progress = shader_material.get_shader_parameter(PROGRESS)
	if current_progress == null:
		current_progress = 1.0
	main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + PROGRESS, 0.0, speed * float(current_progress))	
