class_name SSDMUIPositionScene
extends SSDMUITransformSceneBase


@export var offset: Vector2 = Vector2(20.0, 20.0)

	
func set_x_offset(new_x_offset: float) -> void:
	var position_animator: SSDMUIPositionAnimator = _animator
	position_animator.set_x_offset(new_x_offset)
	
	
func set_y_offset(new_y_offset: float) -> void:
	var position_animator: SSDMUIPositionAnimator = _animator
	position_animator.set_y_offset(new_y_offset)
	
	
func set_position_offset(new_offset: Vector2) -> void:
	var position_animator: SSDMUIPositionAnimator = _animator
	position_animator.set_position_offset(new_offset)
	
	
func _ready() -> void:
	_animator = SSDMUIPositionAnimator.new(self, self, SSDMUIGlobal.POSITION_PROPERTY, speed, Vector2.ZERO, offset, transition_type, ease_type_play, ease_type_reverse)
	_animator.set_panel_container(panel_container)
	_animator.set_background_color(background_color)
	_animator.set_content(content)
