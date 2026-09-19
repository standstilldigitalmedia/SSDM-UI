class_name SSDMUIRotateScene
extends SSDMUITransformSceneBase

@export var from_degrees: float = 0.0
@export var to_degrees: float = 360.0 
@export var pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER

@export_group("Controls")
@export var isolation: Control


func set_from_degrees(new_from_degrees: float) -> void:
	var rotate_animator: SSDMUIRotateAnimator = _animator
	rotate_animator.set_from_degrees(new_from_degrees)
	
	
func set_to_degrees(new_to_degrees: float) -> void:
	var rotate_animator: SSDMUIRotateAnimator = _animator
	rotate_animator.set_to_degrees(new_to_degrees)
	
	
func set_pivot_preset(new_pivot_preset: SSDMUIGlobal.RotationPivot) -> void:
	var rotate_animator: SSDMUIRotateAnimator = _animator
	rotate_animator.set_pivot_preset(new_pivot_preset)
	
	
func _ready() -> void:
	_animator = SSDMUIRotateAnimator.new(isolation, SSDMUIGlobal.ROTATION_PROPERTY, from_degrees, to_degrees, duration, panel_container, transition_type, ease_type_play, ease_type_reverse)
	var rotate_animator: SSDMUIRotateAnimator = _animator
	rotate_animator.set_panel_container(panel_container)
	rotate_animator.set_background_color(background_color)
	rotate_animator.set_content(content)
	rotate_animator.set_isolation(isolation)
	rotate_animator.set_pivot_preset(pivot_preset)
