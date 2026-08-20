class_name SSDMUIControlPositionAnimator
extends SSDMUISingleControlTransformAnimatorBase

@export var position_speed: float = 1.0
@export var position_offset: Vector2 = Vector2(20.0, 20.0)  ## Starting offset position in pixels. Animates to (0,0).

@export_group("Easing")
@export var position_transition_type: Tween.TransitionType = Tween.TRANS_CUBIC  ## Math curve for animation motion.
@export var position_ease_type_open: Tween.EaseType = Tween.EASE_OUT  ## Easing for opening/forward animation.
@export var position_ease_type_close: Tween.EaseType = Tween.EASE_IN  ## Easing for closing/reverse animation.
	

func set_speed(new_speed) -> void:
	position_speed = new_speed
	
	
func set_x_offset(new_x_offset: float) -> void:
	position_offset = Vector2(new_x_offset, position_offset.y)
	
	
func set_y_offset(new_y_offset: float) -> void:
	position_offset = Vector2(position_offset.x, new_y_offset)
	
	
func set_position_offset(new_offset: Vector2) -> void:
	position_offset = new_offset
	
	
func set_transition_type(new_trans_type: Tween.TransitionType) -> void:
	position_transition_type = new_trans_type
	
	
func set_ease_type_open(new_open_type: Tween.EaseType) -> void:
	position_ease_type_open = new_open_type
	
	
func set_ease_type_close(new_close_type: Tween.EaseType) -> void:
	position_ease_type_close = new_close_type
	
	
func _init_tween_forward() -> void:
	position = Vector2.ZERO
	
	
func _init_tween_reverse() -> void:
	position = position_offset
	
	
func _tween_forward() -> void:
	main_tween.tween_property(self, POSITION_PROPERTY, position_offset, position_speed)
	await main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	main_tween.tween_property(self, POSITION_PROPERTY, Vector2.ZERO, position_speed)
	await main_tween.finished
	finished.emit()
	
	
func _create_open_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(position_ease_type_open)
	main_tween.set_trans(position_transition_type)
	
	
func _create_close_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(position_ease_type_close)
	main_tween.set_trans(position_transition_type)
