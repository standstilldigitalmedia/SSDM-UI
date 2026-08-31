class_name SSDMUIControlPositionAnimator
extends SSDMUISingleControlTransformAnimatorBase

const POSITION_PROPERTY: String = "position"

@export var offset: Vector2 = Vector2(20.0, 20.0)  ## Starting offset position in pixels. Animates to (0,0).
	
	
func set_x_offset(new_x_offset: float) -> void:
	offset = Vector2(new_x_offset, offset.y)
	
	
func set_y_offset(new_y_offset: float) -> void:
	offset = Vector2(offset.x, new_y_offset)
	
	
func set_position_offset(new_offset: Vector2) -> void:
	offset = new_offset
	
	
func _tween_forward() -> void:
	position = Vector2.ZERO
	_main_tween.tween_property(self, POSITION_PROPERTY, offset, speed)
	await _main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	position = offset
	_main_tween.tween_property(self, POSITION_PROPERTY, Vector2.ZERO, speed)
	await _main_tween.finished
	finished.emit()
