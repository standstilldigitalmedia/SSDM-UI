class_name SSDMUIControlShakeAnimator
extends Control

signal finished

@export var shake_amount: float = 3.0  ## Maximum shake distance in pixels. Typical range: 2-10 pixels.
@export var shake_speed: float = 0.05  ## Time between shake updates in seconds. Typical range: 0.01-0.1 seconds.

@export_group("Controls")
@export var panel_container: PanelContainer

	
func play() -> void:
	var shake_tween = create_tween()
	shake_tween.tween_property(panel_container, SSDMUISingleControlTransformAnimatorBase.POSITION_X_PROPERTY, shake_amount, shake_speed)
	shake_tween.tween_property(panel_container, SSDMUISingleControlTransformAnimatorBase.POSITION_X_PROPERTY, -shake_amount, shake_speed)
	shake_tween.tween_property(panel_container, SSDMUISingleControlTransformAnimatorBase.POSITION_X_PROPERTY, shake_amount / 2.0, shake_speed)
	shake_tween.tween_property(panel_container, SSDMUISingleControlTransformAnimatorBase.POSITION_X_PROPERTY, 0, shake_speed)
	await shake_tween.finished
	finished.emit()
	
	
func reverse() -> void:
	play()
