class_name SSDMUIPositionAnimator
extends SSDMUITransformAnimatorBase
	
	
func set_x_offset(new_x_offset: float) -> void:
	_final_value = Vector2(new_x_offset, _final_value.y)
	
	
func set_y_offset(new_y_offset: float) -> void:
	_final_value = Vector2(_final_value.x, new_y_offset)
	
	
func set_position_offset(new_offset: Vector2) -> void:
	_final_value = new_offset
