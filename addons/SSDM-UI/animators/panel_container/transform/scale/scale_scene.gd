class_name SSDMUIScaleScene
extends Control

@export var speed: float = 1.0
@export var scale_from: Vector2 = Vector2.ONE
@export var scale_to: Vector2 = Vector2(0.0, 0.0)
@export var pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var content: Control
@export var panel_container: PanelContainer

var animator: SSDMUIScaleAnimator


func set_speed(new_speed: float) -> void:
	animator.set_speed(new_speed)
	
	
func set_x_scale_to(new_x_scale_to: float) -> void:
	animator.set_x_scale_to(new_x_scale_to)
	
	
func set_y_scale_to(new_y_scale_to: float) -> void:
	animator.set_y_scale_to(new_y_scale_to)
	
	
func set_x_scale_from(new_x_scale_from: float) -> void:
	animator.set_x_scale_from(new_x_scale_from)
	
	
func set_y_scale_from(new_y_scale_from: float) -> void:
	animator.set_y_scale_from(new_y_scale_from)
	
	
func set_scale_from(new_scale_from: Vector2) -> void:
	animator.set_scale_from(new_scale_from)
	
	
func set_scale_to(new_scale_to: Vector2) -> void:
	animator.set_scale_to(new_scale_to)
	
	
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
	animator = SSDMUIScaleAnimator.new(self, SSDMUIGlobal.SCALE_PROPERTY, speed, scale_from, scale_to, transition_type, ease_type_play, ease_type_reverse)
	animator.set_panel_container(panel_container)
	animator.set_background_color(background_color)
	animator.set_content(content)
	animator.set_pivot_preset(pivot_preset)
