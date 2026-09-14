class_name SSDMUIPositionScene
extends Control

@export var speed: float = 1.0
@export var offset: Vector2 = Vector2(20.0, 20.0)
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None

var animator: SSDMUIControlPositionAnimator


func set_speed(new_speed: float) -> void:
	animator.set_speed(new_speed)
	
	
func set_x_offset(new_x_offset: float) -> void:
	animator.set_x_offset(new_x_offset)
	
	
func set_y_offset(new_y_offset: float) -> void:
	animator.set_y_offset(new_y_offset)
	
	
func set_position_offset(new_offset: Vector2) -> void:
	animator.set_position_offset(new_offset)


func play() -> void:
	animator.play()
	
	
func _ready() -> void:
	animator = SSDMUIControlPositionAnimator.new(self, SSDMUIGlobal.POSITION_PROPERTY, speed, Vector2.ZERO, offset, transition_type, ease_type_play, ease_type_reverse)
