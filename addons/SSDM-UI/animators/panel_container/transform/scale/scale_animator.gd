class_name SSDMUIControlScaleAnimator
extends SSDMUISingleControlTransformAnimatorBase

@export var scale_from: Vector2 = Vector2(0.1, 0.1)  ## Starting scale (1.0 = normal size). Values less than 1.0 start small, greater than 1.0 start large.
@export var scale_to: Vector2 = Vector2.ONE  ## Ending scale (1.0 = normal size). Animation tweens from scale_from to scale_to.
@export var scale_pivot_preset: RotationPivot = RotationPivot.CENTER  ## Point around which scaling occurs.


func _set_tween_forward() -> void:
	panel_container.scale = scale_from
	panel_container.pivot_offset = _get_pivot_offset(panel_container, scale_pivot_preset)
	

func _set_tween_reverse() -> void:
	panel_container.scale = scale_to
	panel_container.pivot_offset = _get_pivot_offset(panel_container, scale_pivot_preset)
	
	
func _tween_forward() -> void:
	main_tween.tween_property(panel_container, SCALE_PROPERTY, scale_to, animation_speed)
	await main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	main_tween.tween_property(panel_container, SCALE_PROPERTY, scale_from, animation_speed)
	await main_tween.finished
	finished.emit()
