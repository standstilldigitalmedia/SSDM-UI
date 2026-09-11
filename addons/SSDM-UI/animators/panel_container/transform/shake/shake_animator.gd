@tool
class_name SSDMUIControlShakeAnimator
extends SSDMUISingleControlTweenedTransformAnimatorBase

@export var amount: float = 3.0 


func set_amount(new_shake_amount: float) -> void:
	amount = new_shake_amount
	

func _tween_forward() -> void:
	_main_tween.tween_property(panel_container, SSDMUIGlobal.POSITION_X_PROPERTY, amount, speed)
	_main_tween.tween_property(panel_container, SSDMUIGlobal.POSITION_X_PROPERTY, -amount, speed)
	_main_tween.tween_property(panel_container, SSDMUIGlobal.POSITION_X_PROPERTY, amount / 2.0, speed)
	_main_tween.tween_property(panel_container, SSDMUIGlobal.POSITION_X_PROPERTY, 0, speed)
	await _main_tween.finished
	finished.emit()
	
	
func _tween_reverse() -> void:
	_tween_forward()
	
	
func _ready() -> void:
	super()
	set_speed(0.05)
