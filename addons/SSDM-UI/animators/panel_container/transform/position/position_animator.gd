class_name SSDMUIPositionAnimator
extends SSDMUITweenedTransformAnimatorBase
	
	
func set_x_offset(new_x_offset: float) -> void:
	_tween_to = Vector2(new_x_offset, _tween_to.y)
	
	
func set_y_offset(new_y_offset: float) -> void:
	_tween_to = Vector2(_tween_to.x, new_y_offset)
	
	
func set_position_offset(new_offset: Vector2) -> void:
	_tween_to = new_offset
