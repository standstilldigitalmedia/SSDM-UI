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

@export var axis: Axis = Axis.VERTICAL  ## Direction of size animation. VERTICAL = slides down/up, HORIZONTAL = slides left/right.
@export var open_direction: OpenDirection = OpenDirection.POSITIVE  ## Which way the panel slides. POSITIVE = down/right, NEGATIVE = up/left.
@export var panel_width: float = 400.0  ## Width in pixels for horizontal slide animations.
var property_name: String
var target_size: float
var current_size: float


func _set_tween_forward() -> void:
	if axis == Axis.VERTICAL:
		property_name = Y_PROPERTY
		target_size = panel_container.get_combined_minimum_size().y
		if open_direction == OpenDirection.POSITIVE:
			size_flags_vertical = 0
			panel_container.grow_vertical = Control.GROW_DIRECTION_BEGIN
		else:
			size_flags_vertical = Control.SIZE_SHRINK_END
			panel_container.grow_vertical = Control.GROW_DIRECTION_END
		custom_minimum_size.y = 0
	else:
		property_name = X_PROPERTY
		target_size = panel_width
		custom_minimum_size.x = panel_width
		size_flags_vertical = Control.SIZE_EXPAND_FILL
		panel_container.grow_vertical = Control.GROW_DIRECTION_BEGIN
		if open_direction == OpenDirection.POSITIVE:
			size_flags_horizontal = 0
			panel_container.grow_horizontal = Control.GROW_DIRECTION_BEGIN
		else:
			size_flags_horizontal = Control.SIZE_SHRINK_END
			panel_container.grow_horizontal = Control.GROW_DIRECTION_END
	
	await get_tree().process_frame
	
	if axis == Axis.VERTICAL:
		target_size = panel_container.get_combined_minimum_size().y
	else:
		var panel_height = panel_container.get_combined_minimum_size().y
		custom_minimum_size.y = panel_height
		custom_minimum_size.x = 0
	
	
func _set_tween_reverse() -> void:
	if axis == Axis.VERTICAL:
		property_name = Y_PROPERTY
		current_size = custom_minimum_size.y if custom_minimum_size.y > 0 else size.y
		size_flags_vertical = 0 if open_direction == OpenDirection.POSITIVE else Control.SIZE_SHRINK_END
	else:
		property_name = X_PROPERTY
		current_size = custom_minimum_size.x if custom_minimum_size.x > 0 else size.x
		size_flags_vertical = Control.SIZE_EXPAND_FILL
		size_flags_horizontal = 0 if open_direction == OpenDirection.POSITIVE else Control.SIZE_SHRINK_END
		

func _tween_forward() -> void:
	main_tween.tween_property(self, property_name, target_size, animation_speed).from(0)
	await main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	main_tween.tween_property(self, property_name, 0, animation_speed).from(current_size)
	await main_tween.finished
	finished.emit()
