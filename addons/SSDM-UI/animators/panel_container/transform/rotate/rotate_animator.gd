class_name SSDMUIControlRotateAnimator
extends SSDMUISingleControlTransformAnimatorBase

@export var rotation_speed: float = 1.0
@export var rotation_from_degrees: float = 0.0  ## Starting rotation angle in degrees.
@export var rotation_to_degrees: float = 360.0  ## Ending rotation angle in degrees. Use 360 for a full spin.
@export var rotation_pivot_preset: RotationPivot = RotationPivot.CENTER  ## Point around which rotation occurs.

@export_group("Easing")
@export var rotation_transition_type: Tween.TransitionType = Tween.TRANS_CUBIC  ## Math curve for animation motion.
@export var rotation_ease_type_open: Tween.EaseType = Tween.EASE_OUT  ## Easing for opening/forward animation.
@export var rotation_ease_type_close: Tween.EaseType = Tween.EASE_IN  ## Easing for closing/reverse animation.

@export_group("Controls")
@export var isolation: Control


func set_speed(new_speed) -> void:
	rotation_speed = new_speed
	

func set_from_degrees(new_from_degrees: float) -> void:
	rotation_from_degrees = new_from_degrees
	
	
func set_to_degrees(new_to_degrees: float) -> void:
	rotation_to_degrees = new_to_degrees
	
	
func set_pivot_preset(new_pivot_preset: RotationPivot) -> void:
	rotation_pivot_preset = new_pivot_preset
	
	
func set_transition_type(new_trans_type: Tween.TransitionType) -> void:
	rotation_transition_type = new_trans_type
	
	
func set_ease_type_open(new_open_type: Tween.EaseType) -> void:
	rotation_ease_type_open = new_open_type
	
	
func set_ease_type_close(new_close_type: Tween.EaseType) -> void:
	rotation_ease_type_close = new_close_type
	
	
func _init_tween_forward() -> void:
	isolation.rotation = deg_to_rad(rotation_from_degrees)
	isolation.pivot_offset = _get_pivot_offset(isolation, rotation_pivot_preset)
	
	
func _init_tween_reverse() -> void:
	isolation.rotation = deg_to_rad(rotation_to_degrees)
	isolation.pivot_offset = _get_pivot_offset(isolation, rotation_pivot_preset)
	
	
func _tween_forward() -> void:
	var to_radians = deg_to_rad(rotation_to_degrees)
	if rotation_to_degrees == 360.0 and rotation_from_degrees == 0.0:
		to_radians = TAU
	main_tween.tween_property(isolation, ROTATION_PROPERTY, to_radians, rotation_speed)
	await main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	var from_radians = deg_to_rad(rotation_from_degrees)
	main_tween.tween_property(isolation, ROTATION_PROPERTY, from_radians, rotation_speed)
	await main_tween.finished
	finished.emit()
	
func _create_open_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(rotation_ease_type_open)
	main_tween.set_trans(rotation_transition_type)
	
	
func _create_close_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(rotation_ease_type_close)
	main_tween.set_trans(rotation_transition_type)
