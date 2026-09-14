class_name SSDMUISlideOutScene
extends Control

@export var speed: float = 1.0
@export var axis: SSDMUIGlobal.Axis = SSDMUIGlobal.Axis.HORIZONTAL
@export var open_direction: SSDMUIGlobal.OpenDirection = SSDMUIGlobal.OpenDirection.POSITIVE
@export var panel_width: float = 200.0
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var content: Control
@export var panel_container: PanelContainer

var animator: SSDMUISlideOutAnimator


func set_speed(new_speed: float) -> void:
	animator.set_speed(new_speed)
	
	
func set_transition_type(new_transition_type) -> void:
	animator.set_transition_type(new_transition_type)


func set_play_ease_type(new_play_ease_type) -> void:
	animator.set_play_ease_type(new_play_ease_type)
	
	
func set_reverse_ease_type(new_reverse_ease_type) -> void:
	animator.set_reverse_ease_type(new_reverse_ease_type)
	
	
func set_background_color(new_background_color) -> void:
	animator.set_background_color(new_background_color)
	

func play() -> void:
	animator.play()
	
	
func reverse() -> void:
	animator.reverse()
	
	
func _ready() -> void:
	animator = SSDMUISlideOutAnimator.new(self, "", speed, 0.0, 0.0, transition_type, ease_type_play, ease_type_reverse)
	panel_container.custom_minimum_size.x = panel_width
	animator.set_panel_container(panel_container)
	animator.set_background_color(background_color)
	animator.set_content(content)
	animator.set_axis(axis)
	animator.set_open_direction(open_direction)
	animator.set_panel_width(panel_width)
