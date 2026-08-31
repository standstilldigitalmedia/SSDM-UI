@abstract class_name SSDMUISingleControlTweenAnimatorBase
extends Control

signal finished

const TRANSISTION_TYPE_NONE: int = 12
const EASE_TYPE_NONE: int = 4

@export var speed: float = 1.0

@export_group("Easing")
@export var transition_type: int = TRANSISTION_TYPE_NONE ## Tween.TransitionType or 12 for none
@export var ease_type_play: int = EASE_TYPE_NONE ## Tween.EaseType or 4 for none
@export var ease_type_reverse: int = EASE_TYPE_NONE ## Tween.EaseType or 4 for none

var _main_tween: Tween
var _set_parallel: bool = false


@abstract func _tween_forward() -> void
@abstract func _tween_reverse() -> void


func set_speed(new_speed) -> void:
	speed = new_speed
	

func set_transition_type(new_trans_type: Tween.TransitionType) -> void:
	transition_type = new_trans_type
	
	
func set_play_ease_type(new_open_type: Tween.EaseType) -> void:
	ease_type_play = new_open_type
	
	
func set_reverse_ease_type(new_close_type: Tween.EaseType) -> void:
	ease_type_reverse = new_close_type
	
	
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
	if ease_type_play < EASE_TYPE_NONE:
		_main_tween.set_ease(ease_type_play)
	if transition_type < TRANSISTION_TYPE_NONE:
		_main_tween.set_trans(transition_type)
	
	
func _create_reverse_tween() -> void:
	_main_tween = create_tween()
	_main_tween.set_parallel(_set_parallel)
	if ease_type_reverse < EASE_TYPE_NONE:
		_main_tween.set_ease(ease_type_reverse)
	if transition_type < TRANSISTION_TYPE_NONE:
		_main_tween.set_trans(transition_type)
