class_name SSDMUIControlSlideOutAnimator
extends SSDMUISingleControlTweenedTransformAnimatorBase

@export var start_full: bool = false
@export var axis: SSDMUIGlobal.Axis = SSDMUIGlobal.Axis.HORIZONTAL
@export var open_direction: SSDMUIGlobal.OpenDirection = SSDMUIGlobal.OpenDirection.POSITIVE
@export var panel_width: float = 200.0

var _property_name: String
var _target_size: float
var _current_size: float


func set_axis(new_slide_axis: SSDMUIGlobal.Axis) -> void:
	axis = new_slide_axis
	
	
func set_open_direction(new_open_direction: SSDMUIGlobal.OpenDirection) -> void:
	open_direction = new_open_direction
	
	
func set_panel_width(new_panel_width: float) -> void:
	panel_width = new_panel_width
	
	
func _init_tween_reverse() -> void:
	if axis == SSDMUIGlobal.Axis.VERTICAL:
		_property_name = SSDMUIGlobal.TRANSFORM_Y_PROPERTY
		_target_size = panel_container.get_combined_minimum_size().y
		if open_direction == SSDMUIGlobal.OpenDirection.POSITIVE:
			size_flags_vertical = 0
			panel_container.grow_vertical = Control.GROW_DIRECTION_BEGIN
		else:
			size_flags_vertical = Control.SIZE_SHRINK_END
			panel_container.grow_vertical = Control.GROW_DIRECTION_END
		custom_minimum_size.y = 0
	else:
		_property_name = SSDMUIGlobal.TRANSFORM_X_PROPERTY
		_target_size = panel_width
		custom_minimum_size.x = panel_width
		size_flags_vertical = Control.SIZE_EXPAND_FILL
		panel_container.grow_vertical = Control.GROW_DIRECTION_BEGIN
		if open_direction == SSDMUIGlobal.OpenDirection.POSITIVE:
			size_flags_horizontal = 0
			panel_container.grow_horizontal = Control.GROW_DIRECTION_BEGIN
		else:
			size_flags_horizontal = Control.SIZE_SHRINK_END
			panel_container.grow_horizontal = Control.GROW_DIRECTION_END
	
	await get_tree().process_frame
	
	if axis == SSDMUIGlobal.Axis.VERTICAL:
		_target_size = panel_container.get_combined_minimum_size().y
	else:
		var panel_height = panel_container.get_combined_minimum_size().y
		custom_minimum_size.y = panel_height
		custom_minimum_size.x = 0
	
	
func _init_tween_forward() -> void:
	if axis == SSDMUIGlobal.Axis.VERTICAL:
		_property_name = SSDMUIGlobal.TRANSFORM_Y_PROPERTY
		_current_size = custom_minimum_size.y if custom_minimum_size.y > 0 else size.y
		if open_direction == SSDMUIGlobal.OpenDirection.POSITIVE:
			size_flags_vertical = 0  
		else: 
			Control.SIZE_SHRINK_END
	else:
		_property_name = SSDMUIGlobal.TRANSFORM_X_PROPERTY
		if custom_minimum_size.x > 0:
			_current_size = custom_minimum_size.x  
		else:
			size.x
		size_flags_vertical = Control.SIZE_EXPAND_FILL
		if open_direction == SSDMUIGlobal.OpenDirection.POSITIVE:
			size_flags_horizontal = 0  
		else:
			Control.SIZE_SHRINK_END
		

func _tween_forward() -> void:
	if start_full:
		_init_tween_forward()
		_main_tween.tween_property(self, _property_name, 0, speed).from(_current_size)
	else:
		_init_tween_reverse()
		_main_tween.tween_property(self, _property_name, _target_size, speed).from(0)
	await _main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	if start_full:
		_init_tween_reverse()
		_main_tween.tween_property(self, _property_name, _target_size, speed).from(0)
	else:
		self.custom_minimum_size.x = panel_width
		_init_tween_forward()
		_main_tween.tween_property(self, _property_name, 0, speed).from(_current_size)
	await _main_tween.finished
	finished.emit()
	
	
func _ready() -> void:
	clip_contents = true
	if start_full:
		self.custom_minimum_size.x = panel_width
	super()
