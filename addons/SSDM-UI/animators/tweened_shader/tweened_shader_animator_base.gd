class_name SSDMUITweenedShaderAnimatorBase
extends RefCounted

var shader_animator: SSDMUIShaderAnimatorBase
var tween_animator: SSDMUITweenAnimatorBase


func set_background_color(new_background_color: Color) -> void:
	shader_animator.set_shader_parameter(SSDMUIGlobal.BACKGROUND_COLOR, new_background_color)


func set_duration(new_duration: float) -> void:
	shader_animator.set_duration(new_duration)
	

func set_shader_parameter(parameter: String, value: Variant) -> void:
	shader_animator.set_shader_parameter(parameter, value)


func set_speed(new_speed: float) -> void:
	tween_animator.set_speed(new_speed)
	
	
func set_transition_type(new_trans_type: SSDMUIGlobal.TransitionType) -> void:
	tween_animator.set_transition_type(new_trans_type)
		
	
func set_play_ease_type(new_play_type: SSDMUIGlobal.EaseType) -> void:
	tween_animator.set_play_ease_type(new_play_type)
	
	
func set_reverse_ease_type(new_reverse_type: SSDMUIGlobal.EaseType) -> void:
	tween_animator.set_reverse_ease_type(new_reverse_type)
	
	
func set_tween_from(new_tween_from: Variant) -> void:
	tween_animator.set_tween_from(new_tween_from)
	
	
func set_tween_to(new_tween_to: Variant) -> void:
	tween_animator.set_tween_to(new_tween_to)
	
	
func stop() -> void:
	shader_animator.stop()
	tween_animator.stop()
		

func play() -> void:
	stop()
	shader_animator.play()
	tween_animator.play()
	
	
func reverse() -> void:
	stop()
	shader_animator.play()
	tween_animator.reverse()
