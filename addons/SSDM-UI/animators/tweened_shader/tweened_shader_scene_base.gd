class_name SSDMUITweenedShaderSceneBase
extends Control

@export var speed: float = 1.0
@export var duration: float = 0.0
@export var background_color: Color = Color(1.0,1.0,1.0,1.0)
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None

@export_group("Controls")
@export var content: Control
@export var animation_target: Control
@export var shader_material: ShaderMaterial

var _animator: SSDMUITweenedShaderAnimatorBase


func set_speed(new_speed: float) -> void:
	_animator.set_speed(new_speed)
	
	
func set_duration(new_duration: float) -> void:
	_animator.set_duration(new_duration)
	
	
func set_background_color(new_background_clor: Color) -> void:
	_animator.set_background_color(new_background_clor)
	
	
func set_transition_type(new_transition_type: SSDMUIGlobal.TransitionType) -> void:
	_animator.set_transition_type(new_transition_type)
	
	
func set_play_ease_type(new_play_ease_type: SSDMUIGlobal.EaseType) -> void:
	_animator.set_play_ease_type(new_play_ease_type)
	
	
func set_reverse_ease_type(new_reverse_ease_type: SSDMUIGlobal.EaseType) -> void:
	_animator.set_reverse_ease_type(new_reverse_ease_type)
	
	
func play() -> void:
	_animator.play()
	
	
func reverse() -> void:
	_animator.reverse()
	
	
func stop() -> void:
	_animator.stop()
