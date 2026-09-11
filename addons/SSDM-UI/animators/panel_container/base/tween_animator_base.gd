@abstract class_name SSDMUISingleControlTweenAnimatorBase
extends Control

signal finished

@export var speed: float = 1.0
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None

var _main_tween: Tween
var _set_parallel: bool = false


@abstract func _tween_forward() -> void
@abstract func _tween_reverse() -> void


func set_speed(new_speed) -> void:
	speed = new_speed
	

func set_transition_type(new_trans_type: SSDMUIGlobal.TransitionType) -> void:
	transition_type = new_trans_type
		
	
func set_play_ease_type(new_play_type: SSDMUIGlobal.EaseType) -> void:
	ease_type_play = new_play_type
	
	
func set_reverse_ease_type(new_reverse_type: SSDMUIGlobal.EaseType) -> void:
	ease_type_reverse = new_reverse_type
	
	
func stop() -> void:
	if _main_tween:
		_main_tween.kill()
		

func play() -> void:
	stop()
	_create_play_tween()
	await _tween_forward()
	
	
func reverse() -> void:
	stop()
	_create_reverse_tween()
	await _tween_reverse()
	
	
func _create_play_tween() -> void:
	_main_tween = create_tween()
	_main_tween.set_parallel(_set_parallel)
	if ease_type_play < int(SSDMUIGlobal.EaseType.None):
		_main_tween.set_ease(int(ease_type_play))
	if transition_type < int(SSDMUIGlobal.TransitionType.None):
		_main_tween.set_trans(int(transition_type))
	
	
func _create_reverse_tween() -> void:
	_main_tween = create_tween()
	_main_tween.set_parallel(_set_parallel)
	if ease_type_reverse < int(SSDMUIGlobal.EaseType.None):
		_main_tween.set_ease(int(ease_type_reverse))
	if transition_type < int(SSDMUIGlobal.TransitionType.None):
		_main_tween.set_trans(int(transition_type))
