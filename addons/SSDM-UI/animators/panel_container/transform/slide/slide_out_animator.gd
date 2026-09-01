class_name SSDMUIControlSlideOutAnimator
extends SSDMUISingleControlTweenedTransformAnimatorBase

const TRANSFORM_X_PROPERTY: String = "custom_minimum_size:x"
const TRANSFORM_Y_PROPERTY: String = "custom_minimum_size:y"

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

@export var axis: Axis = Axis.HORIZONTAL  ## Direction of size animation. VERTICAL = slides down/up, HORIZONTAL = slides left/right.
@export var open_direction: OpenDirection = OpenDirection.POSITIVE  ## Which way the panel slides. POSITIVE = down/right, NEGATIVE = up/left.
@export var panel_width: float = 200.0  ## Width in pixels for horizontal slide animations.

var _property_name: String
var _target_size: float
var _current_size: float


func set_axis(new_slide_axis: Axis) -> void:
	axis = new_slide_axis
	
	
func set_open_direction(new_open_direction: OpenDirection) -> void:
	open_direction = new_open_direction
	
	
func set_panel_width(new_panel_width: float) -> void:
	panel_width = new_panel_width
	
	
func _init_tween_forward() -> void:
	if axis == Axis.VERTICAL:
		_property_name = TRANSFORM_Y_PROPERTY
		_target_size = panel_container.get_combined_minimum_size().y
		if open_direction == OpenDirection.POSITIVE:
			size_flags_vertical = 0
			panel_container.grow_vertical = Control.GROW_DIRECTION_BEGIN
		else:
			size_flags_vertical = Control.SIZE_SHRINK_END
			panel_container.grow_vertical = Control.GROW_DIRECTION_END
		custom_minimum_size.y = 0
	else:
		_property_name = TRANSFORM_X_PROPERTY
		_target_size = panel_width
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
		_target_size = panel_container.get_combined_minimum_size().y
	else:
		var panel_height = panel_container.get_combined_minimum_size().y
		custom_minimum_size.y = panel_height
		custom_minimum_size.x = 0
	
	
func _init_tween_reverse() -> void:
	if axis == Axis.VERTICAL:
		_property_name = TRANSFORM_Y_PROPERTY
		_current_size = custom_minimum_size.y if custom_minimum_size.y > 0 else size.y
		size_flags_vertical = 0 if open_direction == OpenDirection.POSITIVE else Control.SIZE_SHRINK_END
	else:
		_property_name = TRANSFORM_X_PROPERTY
		_current_size = custom_minimum_size.x if custom_minimum_size.x > 0 else size.x
		size_flags_vertical = Control.SIZE_EXPAND_FILL
		size_flags_horizontal = 0 if open_direction == OpenDirection.POSITIVE else Control.SIZE_SHRINK_END
		

func _tween_forward() -> void:
	_init_tween_forward()
	_main_tween.tween_property(self, _property_name, _target_size, speed).from(0)
	await _main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	_init_tween_reverse()
	_main_tween.tween_property(self, _property_name, 0, speed).from(_current_size)
	await _main_tween.finished
	finished.emit()
	
	
func _ready() -> void:
	clip_contents = true
	super()
