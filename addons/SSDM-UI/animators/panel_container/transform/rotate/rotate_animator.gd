class_name SSDMUIControlRotateAnimator
extends SSDMUITweenedTransformAnimatorBase

var from_degrees: float = 0.0
var to_degrees: float = 360.0 
var pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
var isolation: Control


func set_from_degrees(new_from_degrees: float) -> void:
	from_degrees = new_from_degrees
	_set_tween_to_and_from()
	
	
func set_to_degrees(new_to_degrees: float) -> void:
	to_degrees = new_to_degrees
	_set_tween_to_and_from()
	
	
func set_pivot_preset(new_pivot_preset: SSDMUIGlobal.RotationPivot) -> void:
	pivot_preset = new_pivot_preset
	isolation.pivot_offset = _get_pivot_offset(isolation, new_pivot_preset)
	
	
func _set_tween_to_and_from() -> void:
	var to_radians = deg_to_rad(to_degrees)
	if (to_degrees == 360.0 and from_degrees == 0.0) or (to_degrees == 0.0 and from_degrees == 360.0):
		to_radians = TAU
	_tween_to = to_radians
	var from_radians = deg_to_rad(from_degrees)
	if (from_degrees == 360.0 and to_degrees == 0.0) or (from_degrees == 0.0 and to_degrees == 360.0):
		from_radians = TAU
	_tween_from = from_radians
	
	
func _tween_forward() -> void:
	isolation.pivot_offset = _get_pivot_offset(isolation, pivot_preset)
	_set_tween_to_and_from()
	super()
	
	
func _tween_reverse() -> void:
	isolation.pivot_offset = _get_pivot_offset(isolation, pivot_preset)
	_set_tween_to_and_from()
	super()
