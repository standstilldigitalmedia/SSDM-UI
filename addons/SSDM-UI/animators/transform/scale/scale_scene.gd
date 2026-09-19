class_name SSDMUIScaleScene
extends SSDMUITransformSceneBase

@export var scale_from: Vector2 = Vector2.ONE
@export var scale_to: Vector2 = Vector2(0.0, 0.0)
@export var pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER


func set_x_scale_to(new_x_scale_to: float) -> void:
	_animator.set_x_scale_to(new_x_scale_to)
	
	
func set_y_scale_to(new_y_scale_to: float) -> void:
	_animator.set_y_scale_to(new_y_scale_to)
	
	
func set_x_scale_from(new_x_scale_from: float) -> void:
	_animator.set_x_scale_from(new_x_scale_from)
	
	
func set_y_scale_from(new_y_scale_from: float) -> void:
	_animator.set_y_scale_from(new_y_scale_from)
	
	
func set_scale_from(new_scale_from: Vector2) -> void:
	_animator.set_scale_from(new_scale_from)
	
	
func set_scale_to(new_scale_to: Vector2) -> void:
	_animator.set_scale_to(new_scale_to)
	
	
func set_pivot_preset(new_pivot_preset: SSDMUIGlobal.RotationPivot) -> void:
	_animator.set_pivot_preset(new_pivot_preset)
	
	
func _ready() -> void:
	_animator = SSDMUIScaleAnimator.new(panel_container, SSDMUIGlobal.SCALE_PROPERTY, scale_from, scale_to, duration, panel_container, transition_type, ease_type_play, ease_type_reverse)
	_animator.set_panel_container(panel_container)
	_animator.set_background_color(background_color)
	_animator.set_content(content)
	_animator.set_pivot_preset(pivot_preset)
