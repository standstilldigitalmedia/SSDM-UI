class_name SSDMUIControlRotateAnimator
extends SSDMUISingleControlTransformAnimatorBase

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
	
	
func set_transition_type(new_trans_type: Tween.TransitionType) -> void:
	transition_type = new_trans_type
	
	
func set_ease_type_open(new_open_type: Tween.EaseType) -> void:
	ease_type_open = new_open_type
	
	
func set_ease_type_close(new_close_type: Tween.EaseType) -> void:
	ease_type_close = new_close_type
	
	
func _init_tween_forward() -> void:
	isolation.rotation = deg_to_rad(from_degrees)
	isolation.pivot_offset = _get_pivot_offset(isolation, pivot_preset)
	
	
func _init_tween_reverse() -> void:
	isolation.rotation = deg_to_rad(to_degrees)
	isolation.pivot_offset = _get_pivot_offset(isolation, pivot_preset)
	
	
func _tween_forward() -> void:
	var to_radians = deg_to_rad(to_degrees)
	if to_degrees == 360.0 and from_degrees == 0.0:
		to_radians = TAU
	main_tween.tween_property(isolation, ROTATION_PROPERTY, to_radians, speed)
	await main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	var from_radians = deg_to_rad(from_degrees)
	main_tween.tween_property(isolation, ROTATION_PROPERTY, from_radians, speed)
	await main_tween.finished
	finished.emit()
