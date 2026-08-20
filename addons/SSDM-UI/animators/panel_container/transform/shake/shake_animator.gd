class_name SSDMUIControlShakeAnimator
extends Control

signal finished

@export var shake_speed: float = 0.05  ## Time between shake updates in seconds. Typical range: 0.01-0.1 seconds.
@export var shake_amount: float = 3.0  ## Maximum shake distance in pixels. Typical range: 2-10 pixels.
@export var background_color: Color = Color(1,1,1,1)
@export_group("Controls")
@export var panel_container: PanelContainer


func set_speed(new_speed) -> void:
	shake_speed = new_speed
	
	
func set_amount(new_shake_amount: float) -> void:
	shake_amount = new_shake_amount
	
	
func set_background_color(new_color: Color) -> void:
	var new_style_box: StyleBox = panel_container.get_theme_stylebox(SSDMUISingleControlTransformAnimatorBase.PANEL_THEME)
	new_style_box.bg_color = new_color
	
	
func play() -> void:
	var shake_tween = create_tween()
	shake_tween.tween_property(panel_container, SSDMUISingleControlTransformAnimatorBase.POSITION_X_PROPERTY, shake_amount, shake_speed)
	shake_tween.tween_property(panel_container, SSDMUISingleControlTransformAnimatorBase.POSITION_X_PROPERTY, -shake_amount, shake_speed)
	shake_tween.tween_property(panel_container, SSDMUISingleControlTransformAnimatorBase.POSITION_X_PROPERTY, shake_amount / 2.0, shake_speed)
	shake_tween.tween_property(panel_container, SSDMUISingleControlTransformAnimatorBase.POSITION_X_PROPERTY, 0, shake_speed)
	await shake_tween.finished
	finished.emit()
	
	
func _ready() -> void:
	set_background_color(background_color)
