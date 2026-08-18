class_name SSDMDissolveAnimator
extends SSDMPanelShaderAnimatorBase

signal finished

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
	
	
func forward_progress() -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.DISSOLVE_PROGRESS, 0.0)
	
	
func reverse_progress() -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.DISSOLVE_PROGRESS, 1.0)


func set_shader_paramaters() -> void:
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.BG_COLOR, dissolve_background_color)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.DISSOLVE_MODE, dissolve_mode)
	shader_material.set_shader_parameter(SSDMCanvasShaderGlobal.DISSOLVE_SPREAD, dissolve_spread)
	

func create_new_tween() -> void:
	if main_tween:
		main_tween.kill()
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(dissolve_ease_type_open)
	main_tween.set_trans(dissolve_transition_type)
	

func tween_forward() -> void:
	main_tween.tween_property(shader_material, SSDMCanvasShaderGlobal.SHADER_PARAMETER + SSDMCanvasShaderGlobal.DISSOLVE_PROGRESS, 1.0, dissolve_speed)
	
	
func tween_reverse() -> void:
	var current_progress = shader_material.get_shader_parameter(SSDMCanvasShaderGlobal.DISSOLVE_PROGRESS)
	if current_progress == null:
		current_progress = 1.0
	main_tween.tween_property(shader_material, SSDMCanvasShaderGlobal.SHADER_PARAMETER + SSDMCanvasShaderGlobal.DISSOLVE_PROGRESS, 0.0, dissolve_speed * float(current_progress))	
	
	
func play() -> void:
	create_new_tween()
	enable_shader()
	forward_progress()
	tween_forward()
	await main_tween.finished
	disable_shader()
	var new_style_box: StyleBox = StyleBoxFlat.new()
	new_style_box.set("bg_color", dissolve_background_color)
	add_theme_stylebox_override("panel", new_style_box)
	finished.emit()
	
	
func reverse() -> void:
	create_new_tween()
	enable_shader()
	reverse_progress()
	tween_reverse()
	await main_tween.finished
	disable_shader()
	add_theme_stylebox_override("panel", original_style_box)
	finished.emit()
	
	
func kill() -> void:
	if main_tween:
		main_tween.kill()
	disable_shader()
