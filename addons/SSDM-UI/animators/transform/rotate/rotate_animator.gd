class_name SSDMUIRotateAnimator
extends SSDMUITransformAnimatorBase

var pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
var isolation: Control


func set_from_degrees(new_from_degrees: float) -> void:
	_tween_from = deg_to_rad(new_from_degrees)
	
	
func set_to_degrees(new_to_degrees: float) -> void:
	_tween_to = deg_to_rad(new_to_degrees)
	
	
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
	super(tween_target, tween_parent, tween_property_name, speed, tween_from, tween_to, transition_type, ease_type_play, ease_type_reverse)
	_tween_from = deg_to_rad(tween_from)
	_tween_to = deg_to_rad(tween_to)
