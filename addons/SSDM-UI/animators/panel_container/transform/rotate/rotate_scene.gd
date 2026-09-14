class_name SSDMUIRotateScene
extends Control

@export var speed: float = 1.0
@export var from_degrees: float = 0.0
@export var to_degrees: float = 360.0 
@export var pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var content: Control
@export var panel_container: PanelContainer
@export var isolation: Control

var animator: SSDMUIRotateAnimator


func set_speed(new_speed: float) -> void:
	animator.set_speed(new_speed)
	
	
func set_from_degrees(new_from_degrees: float) -> void:
	animator.set_from_degrees(new_from_degrees)
	
	
func set_to_degrees(new_to_degrees: float) -> void:
	animator.set_to_degrees(new_to_degrees)
	
	
func set_pivot_preset(new_pivot_preset: SSDMUIGlobal.RotationPivot) -> void:
	animator.set_pivot_preset(new_pivot_preset)
	
	
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
	animator = SSDMUIRotateAnimator.new(isolation, SSDMUIGlobal.ROTATION_PROPERTY, speed, from_degrees, to_degrees, transition_type, ease_type_play, ease_type_reverse)
	animator.set_panel_container(panel_container)
	animator.set_background_color(background_color)
	animator.set_content(content)
	animator.set_isolation(isolation)
	animator.set_pivot_preset(pivot_preset)
