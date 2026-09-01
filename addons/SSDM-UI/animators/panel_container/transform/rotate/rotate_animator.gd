class_name SSDMUIControlRotateAnimator
extends SSDMUISingleControlTweenedTransformAnimatorBase

const ROTATION_PROPERTY: String = "rotation"

@export var from_degrees: float = 0.0  ## Starting rotation angle in degrees.
@export var to_degrees: float = 360.0  ## Ending rotation angle in degrees. Use 360 for a full spin.
@export var pivot_preset: RotationPivot = RotationPivot.CENTER  ## Point around which rotation occurs.

@export_group("Controls")
@export var isolation: Control


func set_from_degrees(new_from_degrees: float) -> void:
	from_degrees = new_from_degrees
	
	
func set_to_degrees(new_to_degrees: float) -> void:
	to_degrees = new_to_degrees
	
	
func set_pivot_preset(new_pivot_preset: RotationPivot) -> void:
	pivot_preset = new_pivot_preset
	
	
func _tween_forward() -> void:
	isolation.rotation = deg_to_rad(from_degrees)
	isolation.pivot_offset = _get_pivot_offset(isolation, pivot_preset)
	var to_radians = deg_to_rad(to_degrees)
	if to_degrees == 360.0 and from_degrees == 0.0:
		to_radians = TAU
	_main_tween.tween_property(isolation, ROTATION_PROPERTY, to_radians, speed)
	await _main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	isolation.rotation = deg_to_rad(to_degrees)
	isolation.pivot_offset = _get_pivot_offset(isolation, pivot_preset)
	var from_radians = deg_to_rad(from_degrees)
	_main_tween.tween_property(isolation, ROTATION_PROPERTY, from_radians, speed)
	await _main_tween.finished
	finished.emit()
