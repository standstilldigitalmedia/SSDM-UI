class_name SSDMUIControlRotateAnimator
extends SSDMUISingleControlTweenedTransformAnimatorBase

@export var from_degrees: float = 0.0
@export var to_degrees: float = 360.0 
@export var pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER

@export_group("Controls")
@export var isolation: Control


func set_from_degrees(new_from_degrees: float) -> void:
	from_degrees = new_from_degrees
	
	
func set_to_degrees(new_to_degrees: float) -> void:
	to_degrees = new_to_degrees
	
	
func set_pivot_preset(new_pivot_preset: SSDMUIGlobal.RotationPivot) -> void:
	pivot_preset = new_pivot_preset
	isolation.pivot_offset = _get_pivot_offset(isolation, new_pivot_preset)
	
	
func _tween_forward() -> void:
	isolation.pivot_offset = _get_pivot_offset(isolation, pivot_preset)
	isolation.rotation = deg_to_rad(from_degrees)
	var to_radians = deg_to_rad(to_degrees)
	if to_degrees == 360.0 and from_degrees == 0.0:
		to_radians = TAU
	_main_tween.tween_property(isolation, SSDMUIGlobal.ROTATION_PROPERTY, to_radians, speed)
	await _main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	isolation.pivot_offset = _get_pivot_offset(isolation, pivot_preset)
	isolation.rotation = deg_to_rad(to_degrees)
	var from_radians = deg_to_rad(from_degrees)
	_main_tween.tween_property(isolation, SSDMUIGlobal.ROTATION_PROPERTY, from_radians, speed)
	await _main_tween.finished
	finished.emit()
	
	
func _ready() -> void:
	super()
