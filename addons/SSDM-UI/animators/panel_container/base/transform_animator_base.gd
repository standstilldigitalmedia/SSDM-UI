@abstract class_name SSDMUITransformAnimatorBase
extends RefCounted

signal finished

var background_color: Color = Color(1,1,1,1)
var content: Control
var panel_container: PanelContainer
var tween_target: Control
var speed: float = 1.0
var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None

var _main_tween: Tween
var _set_parallel: bool = false


@abstract func _tween_forward() -> void
@abstract func _tween_reverse() -> void


func set_background_color(new_background_color: Color) -> void:
	var new_style_box: StyleBox = panel_container.get_theme_stylebox(SSDMUIGlobal.PANEL_THEME)
	new_style_box.bg_color = new_background_color
	background_color = new_background_color
	
	
func set_content(new_content: Control) -> void:
	if content:
		await content.call_deferred("queue_free")
	content = new_content
	await content.call_deferred("reparent", panel_container)
	

func set_speed(new_speed) -> void:
	speed = new_speed
	

func set_transition_and_easing(new_trans_type: SSDMUIGlobal.TransitionType, new_play_type: SSDMUIGlobal.EaseType, new_reverse_type: SSDMUIGlobal.EaseType) -> void:
	transition_type = new_trans_type
	ease_type_play = new_play_type	
	ease_type_reverse = new_reverse_type	
	
	
func stop() -> void:
	if _main_tween:
		_main_tween.kill()
		

func play() -> void:
	stop()
	_create_play_tween()
	await _tween_forward()
	
	
func reverse() -> void:
	stop()
	_create_reverse_tween()
	await _tween_reverse()
	
	
func _create_play_tween() -> void:
	if !_main_tween:
		_main_tween = tween_target.create_tween()
		_main_tween.set_parallel(_set_parallel)
		if ease_type_play < int(SSDMUIGlobal.EaseType.None):
			_main_tween.set_ease(int(ease_type_play))
		if transition_type < int(SSDMUIGlobal.TransitionType.None):
			_main_tween.set_trans(int(transition_type))
	
	
func _create_reverse_tween() -> void:
	if !_main_tween:
		_main_tween = tween_target.create_tween()
		_main_tween.set_parallel(_set_parallel)
		if ease_type_reverse < int(SSDMUIGlobal.EaseType.None):
			_main_tween.set_ease(int(ease_type_reverse))
		if transition_type < int(SSDMUIGlobal.TransitionType.None):
			_main_tween.set_trans(int(transition_type))


func _get_pivot_offset(node: Control, preset: SSDMUIGlobal.RotationPivot) -> Vector2:
	match preset:
		SSDMUIGlobal.RotationPivot.TOP_LEFT:
			return Vector2.ZERO
		SSDMUIGlobal.RotationPivot.TOP_CENTER:
			return Vector2(node.size.x / 2, 0)
		SSDMUIGlobal.RotationPivot.TOP_RIGHT:
			return Vector2(node.size.x, 0)
		SSDMUIGlobal.RotationPivot.CENTER_LEFT:
			return Vector2(0, node.size.y / 2)
		SSDMUIGlobal.RotationPivot.CENTER:
			return node.size / 2
		SSDMUIGlobal.RotationPivot.CENTER_RIGHT:
			return Vector2(node.size.x, node.size.y / 2)
		SSDMUIGlobal.RotationPivot.BOTTOM_LEFT:
			return Vector2(0, node.size.y)
		SSDMUIGlobal.RotationPivot.BOTTOM_CENTER:
			return Vector2(node.size.x / 2, node.size.y)
		SSDMUIGlobal.RotationPivot.BOTTOM_RIGHT:
			return node.size
	return Vector2.ZERO
	
	
func _init(icontent: Control, ipanel_container: PanelContainer, itween_target: Control, main_tween: Tween = null) -> void:
	content = icontent
	panel_container = ipanel_container
	tween_target = itween_target
	_main_tween = main_tween
	if content:
		await content.get_tree().process_frame
		content.reparent(panel_container)
	set_background_color(background_color)
