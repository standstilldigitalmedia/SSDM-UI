class_name SSDMUIControlRotateAnimator
extends SSDMUISingleControlTransformAnimatorBase

@export var rotation_from_degrees: float = 0.0  ## Starting rotation angle in degrees.
@export var rotation_to_degrees: float = 360.0  ## Ending rotation angle in degrees. Use 360 for a full spin.
@export var rotation_pivot_preset: RotationPivot = RotationPivot.CENTER  ## Point around which rotation occurs.

@export_group("Controls")
@export var isolation: Control


func _set_tween_forward() -> void:
	isolation.rotation = deg_to_rad(rotation_from_degrees)
	isolation.pivot_offset = _get_pivot_offset(isolation, rotation_pivot_preset)
	
	
func _set_tween_reverse() -> void:
	isolation.rotation = deg_to_rad(rotation_to_degrees)
	isolation.pivot_offset = _get_pivot_offset(isolation, rotation_pivot_preset)
	
	
func _tween_forward() -> void:
	var to_radians = deg_to_rad(rotation_to_degrees)
	if rotation_to_degrees == 360.0 and rotation_from_degrees == 0.0:
		to_radians = TAU
	main_tween.tween_property(isolation, ROTATION_PROPERTY, to_radians, animation_speed)
	await main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	var from_radians = deg_to_rad(rotation_from_degrees)
	main_tween.tween_property(isolation, ROTATION_PROPERTY, from_radians, animation_speed)
	await main_tween.finished
	finished.emit()
