class_name SSDMUIScaleAnimator
extends SSDMUITransformAnimatorBase

var pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER


func set_x_scale_from(new_x_scale_from: float) -> void:
	_tween_from = Vector2(new_x_scale_from, _tween_from.y)
	
	
func set_y_scale_from(new_y_scale_from: float) -> void:
	_tween_from = Vector2(_tween_from.x, new_y_scale_from)
	
		
func set_scale_from(new_scale_from: Vector2) -> void:
	_tween_from = new_scale_from
	
	
func set_x_scale_to(new_x_scale_to: float) -> void:
	_tween_to = Vector2(new_x_scale_to, _tween_to.y)
	
	
func set_y_scale_to(new_y_scale_to: float) -> void:
	_tween_to = Vector2(_tween_to.x, new_y_scale_to)
	
		
func set_scale_to(new_scale_to: Vector2) -> void:
	_tween_to = new_scale_to
	
	
func set_pivot_preset(new_pivot_preset: SSDMUIGlobal.RotationPivot) -> void:
	pivot_preset = new_pivot_preset
	
	
func _tween_forward() -> void:
	_tween_target.pivot_offset = _get_pivot_offset(panel_container, pivot_preset)
	super()
	
	
func _tween_reverse() -> void:
	_tween_target.pivot_offset = _get_pivot_offset(panel_container, pivot_preset)
	super()
