class_name SSDMUITransformSceneBase
extends Control

@export var duration: float = 1.0
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var content: Control
@export var panel_container: PanelContainer

var _animator: SSDMUITransformAnimatorBase


func set_duration(new_duration: float) -> void:
	_animator.set_duration(new_duration)
	
	
func set_transition_type(new_transition_type) -> void:
	_animator.set_transition_type(new_transition_type)


func set_play_ease_type(new_play_ease_type) -> void:
	_animator.set_play_ease_type(new_play_ease_type)
	
	
func set_reverse_ease_type(new_reverse_ease_type) -> void:
	_animator.set_reverse_ease_type(new_reverse_ease_type)
	
	
func set_background_color(new_background_color) -> void:
	_animator.set_background_color(new_background_color)
	

func play() -> void:
	_animator.play()
	
	
func reverse() -> void:
	_animator.reverse()
	
	
func _ready() -> void:
	_animator.set_panel_container(panel_container)
	_animator.set_background_color(background_color)
	_animator.set_content(content)
