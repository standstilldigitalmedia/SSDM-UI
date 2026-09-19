class_name SSDMUIRotateAnimator
extends SSDMUITransformAnimatorBase

var pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
var isolation: Control


func set_from_degrees(new_from_degrees: float) -> void:
	_begin_value = deg_to_rad(new_from_degrees)
	
	
func set_to_degrees(new_to_degrees: float) -> void:
	_final_value = deg_to_rad(new_to_degrees)
	
	
func set_pivot_preset(new_pivot_preset: SSDMUIGlobal.RotationPivot) -> void:
	pivot_preset = new_pivot_preset
	
	
func set_isolation(new_isolation) -> void:
	isolation = new_isolation
	
	
func _tween_forward() -> void:
	isolation.pivot_offset = _get_pivot_offset(isolation, pivot_preset)
	super()
	
	
func _tween_reverse() -> void:
	isolation.pivot_offset = _get_pivot_offset(isolation, pivot_preset)
	super()
	
	
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
	super(object, property_name, begin_value, final_value, duration, parent, transition_type, ease_type_play, ease_type_reverse)
	begin_value = deg_to_rad(begin_value)
	final_value = deg_to_rad(final_value)
