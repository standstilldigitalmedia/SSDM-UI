class_name SSDMUIControlPositionAnimator
extends SSDMUISingleControlTransformAnimatorBase

@export var position_offset: Vector2 = Vector2(20.0, 20.0)  ## Starting offset position in pixels. Animates to (0,0).


func _set_tween_forward() -> void:
	position = Vector2.ZERO
	
	
func _set_tween_reverse() -> void:
	position = position_offset
	
	
func _tween_forward() -> void:
	main_tween.tween_property(self, POSITION_PROPERTY, position_offset, animation_speed)
	await main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	main_tween.tween_property(self, POSITION_PROPERTY, Vector2.ZERO, animation_speed)
	await main_tween.finished
	finished.emit()
