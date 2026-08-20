class_name SSDMUIControlSlideOutAnimator
extends SSDMUISingleControlTransformAnimatorBase

enum OpenDirection 
{
	POSITIVE,    ## Slide in the positive direction. For VERTICAL = downward, for HORIZONTAL = rightward.
	NEGATIVE     ## Slide in the negative direction. For VERTICAL = upward, for HORIZONTAL = leftward.
}

enum Axis 
{
	VERTICAL,    ## Size animation expands/contracts vertically (top to bottom). Panel slides down when opening, up when closing.
	HORIZONTAL   ## Size animation expands/contracts horizontally (left to right). Panel slides right when opening, left when closing.
}

@export var slide_speed: float = 1.0
@export var slide_axis: Axis = Axis.VERTICAL  ## Direction of size animation. VERTICAL = slides down/up, HORIZONTAL = slides left/right.
@export var slide_open_direction: OpenDirection = OpenDirection.POSITIVE  ## Which way the panel slides. POSITIVE = down/right, NEGATIVE = up/left.
@export var slide_panel_width: float = 400.0  ## Width in pixels for horizontal slide animations.

@export_group("Easing")
@export var slide_transition_type: Tween.TransitionType = Tween.TRANS_CUBIC  ## Math curve for animation motion.
@export var slide_ease_type_open: Tween.EaseType = Tween.EASE_OUT  ## Easing for opening/forward animation.
@export var slide_ease_type_close: Tween.EaseType = Tween.EASE_IN  ## Easing for closing/reverse animation.

var property_name: String
var target_size: float
var current_size: float


func set_speed(new_speed) -> void:
	slide_speed = new_speed
	
	
func set_axis(new_slide_axis: Axis) -> void:
	slide_axis = new_slide_axis
	
	
func set_open_direction(new_open_direction: OpenDirection) -> void:
	slide_open_direction = new_open_direction
	
	
func set_panel_width(new_panel_width: float) -> void:
	slide_panel_width = new_panel_width
	
	
func set_transition_type(new_trans_type: Tween.TransitionType) -> void:
	slide_transition_type = new_trans_type
	
	
func set_ease_type_open(new_open_type: Tween.EaseType) -> void:
	slide_ease_type_open = new_open_type
	
	
func set_ease_type_close(new_close_type: Tween.EaseType) -> void:
	slide_ease_type_close = new_close_type
	
	
func _init_tween_forward() -> void:
	if slide_axis == Axis.VERTICAL:
		property_name = Y_PROPERTY
		target_size = panel_container.get_combined_minimum_size().y
		if slide_open_direction == OpenDirection.POSITIVE:
			size_flags_vertical = 0
			panel_container.grow_vertical = Control.GROW_DIRECTION_BEGIN
		else:
			size_flags_vertical = Control.SIZE_SHRINK_END
			panel_container.grow_vertical = Control.GROW_DIRECTION_END
		custom_minimum_size.y = 0
	else:
		property_name = X_PROPERTY
		target_size = slide_panel_width
		custom_minimum_size.x = slide_panel_width
		size_flags_vertical = Control.SIZE_EXPAND_FILL
		panel_container.grow_vertical = Control.GROW_DIRECTION_BEGIN
		if slide_open_direction == OpenDirection.POSITIVE:
			size_flags_horizontal = 0
			panel_container.grow_horizontal = Control.GROW_DIRECTION_BEGIN
		else:
			size_flags_horizontal = Control.SIZE_SHRINK_END
			panel_container.grow_horizontal = Control.GROW_DIRECTION_END
	
	await get_tree().process_frame
	
	if slide_axis == Axis.VERTICAL:
		target_size = panel_container.get_combined_minimum_size().y
	else:
		var panel_height = panel_container.get_combined_minimum_size().y
		custom_minimum_size.y = panel_height
		custom_minimum_size.x = 0
	
	
func _init_tween_reverse() -> void:
	if slide_axis == Axis.VERTICAL:
		property_name = Y_PROPERTY
		current_size = custom_minimum_size.y if custom_minimum_size.y > 0 else size.y
		size_flags_vertical = 0 if slide_open_direction == OpenDirection.POSITIVE else Control.SIZE_SHRINK_END
	else:
		property_name = X_PROPERTY
		current_size = custom_minimum_size.x if custom_minimum_size.x > 0 else size.x
		size_flags_vertical = Control.SIZE_EXPAND_FILL
		size_flags_horizontal = 0 if slide_open_direction == OpenDirection.POSITIVE else Control.SIZE_SHRINK_END
		

func _tween_forward() -> void:
	main_tween.tween_property(self, property_name, target_size, slide_speed).from(0)
	await main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	main_tween.tween_property(self, property_name, 0, slide_speed).from(current_size)
	await main_tween.finished
	finished.emit()
	
	
func _create_open_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(slide_ease_type_open)
	main_tween.set_trans(slide_transition_type)
	
	
func _create_close_tween() -> void:
	main_tween = create_tween()
	main_tween.set_parallel(false)
	main_tween.set_ease(slide_ease_type_close)
	main_tween.set_trans(slide_transition_type)
