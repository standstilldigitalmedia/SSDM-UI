class_name SSDMUIControlScaleAnimator
extends SSDMUISingleControlTransformAnimatorBase

@export var scale_speed: float = 1.0
@export var scale_from: Vector2 = Vector2(0.1, 0.1)  ## Starting scale (1.0 = normal size). Values less than 1.0 start small, greater than 1.0 start large.
@export var scale_to: Vector2 = Vector2.ONE  ## Ending scale (1.0 = normal size). Animation tweens from scale_from to scale_to.
@export var scale_pivot_preset: RotationPivot = RotationPivot.CENTER  ## Point around which scaling occurs.

@export_group("Easing")
@export var scale_transition_type: Tween.TransitionType = Tween.TRANS_CUBIC  ## Math curve for animation motion.
@export var scale_ease_type_open: Tween.EaseType = Tween.EASE_OUT  ## Easing for opening/forward animation.
@export var scale_ease_type_close: Tween.EaseType = Tween.EASE_IN  ## Easing for closing/reverse animation.


func set_speed(new_speed) -> void:
	scale_speed = new_speed
	

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
	scale_pivot_preset = new_pivot_preset
	
	
func set_transition_type(new_trans_type: Tween.TransitionType) -> void:
	scale_transition_type = new_trans_type
	
	
func set_ease_type_open(new_open_type: Tween.EaseType) -> void:
	scale_ease_type_open = new_open_type
	
	
func set_ease_type_close(new_close_type: Tween.EaseType) -> void:
	scale_ease_type_close = new_close_type
	
	
func _init_tween_forward() -> void:
	panel_container.scale = scale_from
	panel_container.pivot_offset = _get_pivot_offset(panel_container, scale_pivot_preset)
	

func _init_tween_reverse() -> void:
	panel_container.scale = scale_to
	panel_container.pivot_offset = _get_pivot_offset(panel_container, scale_pivot_preset)
	
	
func _tween_forward() -> void:
	main_tween.tween_property(panel_container, SCALE_PROPERTY, scale_to, scale_speed)
	await main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	main_tween.tween_property(panel_container, SCALE_PROPERTY, scale_from, scale_speed)
	await main_tween.finished
	finished.emit()
	
	
func _create_open_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(scale_ease_type_open)
	main_tween.set_trans(scale_transition_type)
	
	
func _create_close_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(scale_ease_type_close)
	main_tween.set_trans(scale_transition_type)
