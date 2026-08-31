class_name SSDMUIControlScaleAnimator
extends SSDMUISingleControlTransformAnimatorBase

const SCALE_PROPERTY: String = "scale"

@export var scale_from: Vector2 = Vector2.ONE
@export var scale_to: Vector2 = Vector2(0.1, 0.1)
@export var pivot_preset: RotationPivot = RotationPivot.CENTER


func set_x_scale_from(new_x_scale_from: float) -> void:
	scale_from = Vector2(new_x_scale_from, scale_from.y)
	
	
func set_y_scale_from(new_y_scale_from: float) -> void:
	scale_from = Vector2(scale_from.x, new_y_scale_from)
	
		
func set_scale_from(new_scale_from: Vector2) -> void:
	scale_from = new_scale_from
	
	
func set_x_scale_to(new_x_scale_to: float) -> void:
	scale_to = Vector2(new_x_scale_to, scale_to.y)
	
	
func set_y_scale_to(new_y_scale_to: float) -> void:
	scale_to = Vector2(scale_to.x, new_y_scale_to)
	
		
func set_scale_to(new_scale_to: Vector2) -> void:
	scale_to = new_scale_to
	
	
func set_pivot_preset(new_pivot_preset: RotationPivot) -> void:
	pivot_preset = new_pivot_preset
	
	
func _tween_forward() -> void:
	panel_container.scale = scale_from
	panel_container.pivot_offset = _get_pivot_offset(panel_container, pivot_preset)
	_main_tween.tween_property(panel_container, SCALE_PROPERTY, scale_to, speed)
	await _main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	panel_container.scale = scale_to
	panel_container.pivot_offset = _get_pivot_offset(panel_container, pivot_preset)
	_main_tween.tween_property(panel_container, SCALE_PROPERTY, scale_from, speed)
	await _main_tween.finished
	finished.emit()
