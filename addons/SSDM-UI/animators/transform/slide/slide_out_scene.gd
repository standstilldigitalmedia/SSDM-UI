class_name SSDMUISlideOutScene
extends SSDMUITransformSceneBase

@export var axis: SSDMUIGlobal.Axis = SSDMUIGlobal.Axis.HORIZONTAL
@export var open_direction: SSDMUIGlobal.OpenDirection = SSDMUIGlobal.OpenDirection.POSITIVE
@export var panel_width: float = 200.0

	
func set_axis(new_slide_axis: SSDMUIGlobal.Axis) -> void:
	_animator.set_axis(new_slide_axis)
	
	
func set_open_direction(new_open_direction: SSDMUIGlobal.OpenDirection) -> void:
	_animator.set_open_direction(new_open_direction)
	
	
func set_panel_width(new_panel_width: float) -> void:
	_animator.set_panel_width(new_panel_width)
	
	
func _ready() -> void:
	_animator = SSDMUISlideOutAnimator.new(self, "", 0.0, 0.0, duration, panel_container, transition_type, ease_type_play, ease_type_reverse)
	panel_container.custom_minimum_size.x = panel_width
	_animator.set_panel_container(panel_container)
	_animator.set_background_color(background_color)
	_animator.set_content(content)
	_animator.set_axis(axis)
	_animator.set_open_direction(open_direction)
	_animator.set_panel_width(panel_width)
