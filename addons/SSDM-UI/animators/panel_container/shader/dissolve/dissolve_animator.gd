class_name SSDMUIControlDissolveAnimator
extends SSDMUISingleControlShaderAnimatorBase

signal finished

const DISSOLVE_ENABLED: String = "dissolve_enabled"
const DISSOLVE_MODE: String = "dissolve_mode"
const DISSOLVE_PROGRESS: String = "dissolve_progress"
const DISSOLVE_SPREAD: String = "dissolve_spread"

enum DissolveMode 
{ 
	UV_SWEEP, 
	NOISE, 
	RADIAL 
}

@export var dissolve_speed: float = 1.0  ## How many seconds the full animation takes.
@export var dissolve_mode: DissolveMode = DissolveMode.NOISE  ## UV_SWEEP = left-to-right; NOISE = random threshold; RADIAL = from center outward.
@export var dissolve_spread: float = 0.1  ## Edge softness of the dissolve transition.
@export var dissolve_ease_type_open: Tween.EaseType = Tween.EASE_OUT  ## Easing for opening/forward animation.
@export var dissolve_transition_type: Tween.TransitionType = Tween.TRANS_CUBIC  ## Math curve for animation motion.
@export var dissolve_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.

var main_tween: Tween


func set_speed(new_speed: float) -> void:
	dissolve_speed = new_speed
	
	
func set_mode(new_mode: DissolveMode) -> void:
	shader_material.set_shader_parameter(DISSOLVE_MODE, new_mode)
	
	
func set_spread(new_spread: float) -> void:
	shader_material.set_shader_parameter(DISSOLVE_SPREAD, new_spread)
	
	
func set_ease_type_open(new_ease_type_open: Tween.EaseType) -> void:
	dissolve_ease_type_open = new_ease_type_open
	
	
func set_transition_type(new_transition_type: Tween.TransitionType) -> void:
	dissolve_transition_type = new_transition_type
	
	
func reverse_progress() -> void:
	shader_material.set_shader_parameter(DISSOLVE_PROGRESS, 0.0)
	
	
func forward_progress() -> void:
	shader_material.set_shader_parameter(DISSOLVE_PROGRESS, 1.0)


func set_shader_paramaters() -> void:
	set_background_color(dissolve_background_color)
	set_mode(dissolve_mode)
	set_spread(dissolve_spread)
	

func create_new_tween() -> void:
	if main_tween:
		main_tween.kill()
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(dissolve_ease_type_open)
	main_tween.set_trans(dissolve_transition_type)
	

func tween_reverse() -> void:
	main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + DISSOLVE_PROGRESS, 1.0, dissolve_speed)
	
	
func tween_forward() -> void:
	var current_progress = shader_material.get_shader_parameter(DISSOLVE_PROGRESS)
	if current_progress == null:
		current_progress = 1.0
	main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + DISSOLVE_PROGRESS, 0.0, dissolve_speed * float(current_progress))	
	
	
func reverse() -> void:
	create_new_tween()
	enable_shader()
	reverse_progress()
	tween_reverse()
	await main_tween.finished
	disable_shader()
	finished.emit()
	
	
func play() -> void:
	create_new_tween()
	enable_shader()
	forward_progress()
	tween_forward()
	await main_tween.finished
	finished.emit()
	
	
func kill() -> void:
	if main_tween:
		main_tween.kill()
	disable_shader()
