@abstract class_name SSDMUISingleControlTweenAnimatorBase
extends Control

signal finished

var main_tween: Tween

@abstract func _init_tween_forward() -> void
@abstract func _init_tween_reverse() -> void
@abstract func _tween_forward() -> void
@abstract func _tween_reverse() -> void


@export var speed: float = 1.0

@export_group("Easing")
@export var transition_type: Tween.TransitionType = Tween.TRANS_CUBIC  ## Math curve for animation motion.
@export var ease_type_open: Tween.EaseType = Tween.EASE_OUT  ## Easing for opening/forward animation.
@export var ease_type_close: Tween.EaseType = Tween.EASE_IN  ## Easing for closing/reverse animation.


func set_speed(new_speed) -> void:
	speed = new_speed
	

func set_transition_type(new_trans_type: Tween.TransitionType) -> void:
	transition_type = new_trans_type
	
	
func set_ease_type_open(new_open_type: Tween.EaseType) -> void:
	ease_type_open = new_open_type
	
	
func set_ease_type_close(new_close_type: Tween.EaseType) -> void:
	ease_type_close = new_close_type
	
	
func kill() -> void:
	if main_tween:
		main_tween.kill()
		

func play() -> void:
	kill()
	_init_tween_forward()
	_create_open_tween()
	await _tween_forward()
	
	
func reverse() -> void:
	kill()
	_init_tween_reverse()
	_create_close_tween()
	await _tween_reverse()
	
	
func _create_open_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(ease_type_open)
	main_tween.set_trans(transition_type)
	
	
func _create_close_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(ease_type_close)
	main_tween.set_trans(transition_type)
