class_name SSDMUIShakeScene
extends SSDMUITransformSceneBase

@export var amount: float = 3.0 


func set_amount(new_amount: float) -> void:
	_animator.set_amount(new_amount)
	
	
func _ready() -> void:
	_animator = SSDMUIShakeAnimator.new(panel_container, SSDMUIGlobal.POSITION_PROPERTY, 0.0, 0.0, duration, panel_container, transition_type, ease_type_play, ease_type_reverse)
	_animator.set_panel_container(panel_container)
	_animator.set_background_color(background_color)
	_animator.set_content(content)
	_animator.set_amount(amount)
