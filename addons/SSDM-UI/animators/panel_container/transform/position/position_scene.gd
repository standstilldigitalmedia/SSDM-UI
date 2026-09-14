class_name SSDMUIPositionScene
extends Control

@export var speed: float = 1.0
@export var offset: Vector2 = Vector2(20.0, 20.0)
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var content: Control
@export var panel_container: PanelContainer

var animator: SSDMUIPositionAnimator


func set_speed(new_speed: float) -> void:
	animator.set_speed(new_speed)
	
	
func set_x_offset(new_x_offset: float) -> void:
	animator.set_x_offset(new_x_offset)
	
	
func set_y_offset(new_y_offset: float) -> void:
	animator.set_y_offset(new_y_offset)
	
	
func set_position_offset(new_offset: Vector2) -> void:
	animator.set_position_offset(new_offset)
	
	
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
	animator = SSDMUIPositionAnimator.new(self, SSDMUIGlobal.POSITION_PROPERTY, speed, Vector2.ZERO, offset, transition_type, ease_type_play, ease_type_reverse)
	animator.set_panel_container(panel_container)
	animator.set_background_color(background_color)
	animator.set_content(content)
