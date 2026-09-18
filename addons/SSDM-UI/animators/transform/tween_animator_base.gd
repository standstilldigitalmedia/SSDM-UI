class_name SSDMUITweenAnimatorBase
extends RefCounted

signal finished

var _tween_target: Variant
var _tween_parent: Control
var _tween_property_name: String
var _speed: float = 1.0
var _tween_from: Variant
var _tween_to: Variant
var _transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
var _ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
var _ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None

var _set_tween: Tween
var _main_tween: Tween
var _set_parallel: bool = false


func set_speed(new_speed) -> void:
	_speed = new_speed
	

func set_transition_type(new_trans_type: SSDMUIGlobal.TransitionType) -> void:
	_transition_type = new_trans_type
		
	
func set_play_ease_type(new_play_type: SSDMUIGlobal.EaseType) -> void:
	_ease_type_play = new_play_type
	
	
func set_reverse_ease_type(new_reverse_type: SSDMUIGlobal.EaseType) -> void:
	_ease_type_reverse = new_reverse_type
	
	
func set_tween_from(new_tween_from: Variant) -> void:
	_tween_from = new_tween_from
	
	
func set_tween_to(new_tween_to: Variant) -> void:
	_tween_to = new_tween_to
	

func set_tween(new_set_tween: Tween) -> void:
	_set_tween = new_set_tween
	
	
static func create_tween(
		tween_parent: Control, 
		transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None, 
		ease_type: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None, 
		parallel: bool = false
	) -> Tween:
	var new_tween: Tween = tween_parent.create_tween()
	new_tween.set_parallel(parallel)
	if transition_type < int(SSDMUIGlobal.TransitionType.None):
		new_tween.set_trans(int(transition_type))
		if ease_type < int(SSDMUIGlobal.EaseType.None):
			new_tween.set_ease(int(ease_type))
	return new_tween
	
	
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
	
	
func _tween_forward() -> void:
	_main_tween.tween_property(_tween_target, _tween_property_name, _tween_to, _speed).from(_tween_from)
	await _main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	_main_tween.tween_property(_tween_target, _tween_property_name, _tween_from, _speed).from(_tween_to)
	await _main_tween.finished
	finished.emit()
	

func _create_play_tween() -> void:
	if _set_tween:
		_main_tween = _set_tween
	else:
		_main_tween = create_tween(_tween_parent, _transition_type, _ease_type_play, _set_parallel)
		
			
func _create_reverse_tween() -> void:
	if _set_tween:
		_main_tween = _set_tween
	else:
		_main_tween = create_tween(_tween_parent, _transition_type, _ease_type_reverse, _set_parallel)
		
		
func _init(
	tween_target: Variant,
	tween_parent: Control,
	tween_property_name: String,
	speed: float,
	tween_from: Variant,
	tween_to: Variant,
	transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None,
	ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None,
	ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
) -> void:
	_tween_target = tween_target
	_tween_parent = tween_parent
	_tween_property_name = tween_property_name
	_speed = speed
	_tween_from = tween_from
	_tween_to = tween_to
	_transition_type = transition_type
	_ease_type_play = ease_type_play
	_ease_type_reverse = ease_type_reverse
