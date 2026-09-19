class_name SSDMUITweenAnimatorBase
extends RefCounted

signal finished

var _object: Variant
var _property_name: String
var _begin_value: Variant
var _final_value: Variant
var _parent: Control
var _duration: float = 1.0
var _transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
var _ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
var _ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None

var _set_tween: Tween
var _main_tween: Tween
var _set_parallel: bool = false


func set_duration(new_duration) -> void:
	_duration = new_duration
	

func set_transition_type(new_trans_type: SSDMUIGlobal.TransitionType) -> void:
	_transition_type = new_trans_type
		
	
func set_play_ease_type(new_play_type: SSDMUIGlobal.EaseType) -> void:
	_ease_type_play = new_play_type
	
	
func set_reverse_ease_type(new_reverse_type: SSDMUIGlobal.EaseType) -> void:
	_ease_type_reverse = new_reverse_type
	
	
func set_begin_value(new_begin_value: Variant) -> void:
	_begin_value = new_begin_value
	
	
func set_final_value(new_final_value: Variant) -> void:
	_final_value = new_final_value
	

func set_tween(new_set_tween: Tween) -> void:
	_set_tween = new_set_tween
	
	
static func create_tween(
		parent: Control, 
		transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None, 
		ease_type: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None, 
		parallel: bool = false
	) -> Tween:
	var new_tween: Tween = parent.create_tween()
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
	_main_tween.tween_property(_object, _property_name, _final_value, _duration).from(_begin_value)
	await _main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	_main_tween.tween_property(_object, _property_name, _begin_value, _duration).from(_final_value)
	await _main_tween.finished
	finished.emit()
	

func _create_play_tween() -> void:
	if _set_tween:
		_main_tween = _set_tween
	else:
		_main_tween = create_tween(_parent, _transition_type, _ease_type_play, _set_parallel)
		
			
func _create_reverse_tween() -> void:
	if _set_tween:
		_main_tween = _set_tween
	else:
		_main_tween = create_tween(_parent, _transition_type, _ease_type_reverse, _set_parallel)
		
		
func _init(
	object: Variant,
	property_name: String,
	begin_value: Variant,
	final_value: Variant,
	duration: float,
	parent: Control,
	transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None,
	ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None,
	ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
) -> void:
	_object = object
	_property_name = property_name
	_begin_value = begin_value
	_final_value = final_value
	_parent = parent
	_duration = duration
	_transition_type = transition_type
	_ease_type_play = ease_type_play
	_ease_type_reverse = ease_type_reverse
