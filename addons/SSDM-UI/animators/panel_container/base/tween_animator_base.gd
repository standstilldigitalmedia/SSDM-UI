@tool
@abstract class_name SSDMUISingleControlTweenAnimatorBase
extends Control


enum TransitionType
{
	BACK,
	BOUNCE,
	CIRC,
	CUBIC,
	ELASTIC,
	EXPO,
	LINEAR,
	QUAD,
	QUART,
	QUINT,
	SINE,
	SPRING,
	NONE,
}

enum EaseType
{
	Ease_In,
	Ease_In_Out,
	Ease_Out,
	Ease_Out_In,
	None,
}

signal finished

@export var speed: float = 1.0
@export_group("Easing")
@export var transition_type: TransitionType = TransitionType.NONE:
	set(value):
		if value == transition_type: 
			return
		transition_type = value
		notify_property_list_changed()
var ease_type_play: EaseType = EaseType.None
var ease_type_reverse: EaseType = EaseType.None

var _main_tween: Tween
var _set_parallel: bool = false


@abstract func _tween_forward() -> void
@abstract func _tween_reverse() -> void


func set_speed(new_speed) -> void:
	speed = new_speed
	

func set_transition_type(new_trans_type: TransitionType) -> void:
	transition_type = new_trans_type
		
	
func set_play_ease_type(new_open_type: EaseType) -> void:
	ease_type_play = new_open_type
	
	
func set_reverse_ease_type(new_close_type: EaseType) -> void:
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
	if ease_type_play < int(EaseType.None):
		_main_tween.set_ease(int(ease_type_play))
	if transition_type < int(TransitionType.NONE):
		_main_tween.set_trans(int(transition_type))
	
	
func _create_reverse_tween() -> void:
	_main_tween = create_tween()
	_main_tween.set_parallel(_set_parallel)
	if ease_type_reverse < int(EaseType.None):
		_main_tween.set_ease(int(ease_type_reverse))
	if transition_type < int(TransitionType.NONE):
		_main_tween.set_trans(int(transition_type))
		
		
func _inspector_set_transistion_type() -> void:
	if transition_type == TransitionType.NONE:
		ease_type_play = EaseType.None
		ease_type_reverse = EaseType.None
		
		
func _get_property_list():
	var ret: Array[Dictionary] = []
	if transition_type == TransitionType.NONE:
		ease_type_play = EaseType.None
		ease_type_reverse = EaseType.None
	else:
		ret.append({
			  "name": &"ease_type_play",
			  "type": TYPE_INT,
			  "usage": PROPERTY_USAGE_DEFAULT,
			  "hint": PROPERTY_HINT_ENUM,
			  "hint_string": ",".join(EaseType.keys()),
		})
		ret.append({
			  "name": &"ease_type_reverse",
			  "type": TYPE_INT,
			  "usage": PROPERTY_USAGE_DEFAULT,
			  "hint": PROPERTY_HINT_ENUM,
			  "hint_string": ",".join(EaseType.keys()),
		})
	return ret
