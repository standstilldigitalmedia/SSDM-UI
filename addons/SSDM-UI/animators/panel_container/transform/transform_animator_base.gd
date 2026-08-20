@abstract class_name SSDMUISingleControlTransformAnimatorBase
extends Control

signal finished

enum RotationPivot 
{
	TOP_LEFT,        ## Rotation/scale pivot at top-left corner of panel. Panel spins around this point.
	TOP_CENTER,      ## Rotation/scale pivot at top-center edge of panel. Creates a pendulum effect when rotating.
	TOP_RIGHT,       ## Rotation/scale pivot at top-right corner of panel. Panel spins around this point.
	CENTER_LEFT,     ## Rotation/scale pivot at center-left edge of panel. Panel rotates around its left side.
	CENTER,          ## Rotation/scale pivot at exact center of panel. Most common for spinning in place.
	CENTER_RIGHT,    ## Rotation/scale pivot at center-right edge of panel. Panel rotates around its right side.
	BOTTOM_LEFT,     ## Rotation/scale pivot at bottom-left corner of panel. Good for "falling leaf" effects.
	BOTTOM_CENTER,   ## Rotation/scale pivot at bottom-center edge of panel. Panel swings from this point.
	BOTTOM_RIGHT,    ## Rotation/scale pivot at bottom-right corner of panel. Good for corner spin effects.
}


const X_PROPERTY: String = "custom_minimum_size:x"
const Y_PROPERTY: String = "custom_minimum_size:y"
const SCALE_PROPERTY: String = "scale"
const MODULATE_A_PROPERTY: String = "modulate:a"
const MODULATE_PROPERTY: String = "modulate"
const ROTATION_PROPERTY: String = "rotation"
const POSITION_PROPERTY: String = "position"
const POSITION_X_PROPERTY: String = "position:x"
const PANEL_THEME: String = "panel"

@export var content: Control
@export var background_color: Color = Color(1,1,1,1)

@export_group("Controls")
@export var panel_container: PanelContainer

var main_tween: Tween
var monitoring: bool = false
var is_open: bool = false


@abstract func set_speed(new_speed: float) -> void
@abstract func set_transition_type(new_trans_type: Tween.TransitionType) -> void
@abstract func set_ease_type_open(new_open_type: Tween.EaseType) -> void
@abstract func set_ease_type_close(new_close_type: Tween.EaseType) -> void
@abstract func _init_tween_forward() -> void
@abstract func _init_tween_reverse() -> void
@abstract func _tween_forward() -> void
@abstract func _tween_reverse() -> void
@abstract func _create_open_tween() -> void
@abstract func _create_close_tween() -> void

func set_background_color(new_color: Color) -> void:
	var new_style_box: StyleBox = panel_container.get_theme_stylebox(PANEL_THEME)
	new_style_box.bg_color = new_color
	

func kill_tween() -> void:
	if main_tween:
		main_tween.kill()

func play() -> void:
	kill_tween()
	_init_tween_forward()
	_create_open_tween()
	await _tween_forward()
	
	
func reverse() -> void:
	kill_tween()
	_init_tween_reverse()
	_create_close_tween()
	await _tween_reverse()
	

## Calculates the pivot offset based on preset.[br][br]
func _get_pivot_offset(node: Control, preset: RotationPivot) -> Vector2:
	match preset:
		RotationPivot.TOP_LEFT:
			return Vector2.ZERO
		RotationPivot.TOP_CENTER:
			return Vector2(node.size.x / 2, 0)
		RotationPivot.TOP_RIGHT:
			return Vector2(node.size.x, 0)
		RotationPivot.CENTER_LEFT:
			return Vector2(0, node.size.y / 2)
		RotationPivot.CENTER:
			return node.size / 2
		RotationPivot.CENTER_RIGHT:
			return Vector2(node.size.x, node.size.y / 2)
		RotationPivot.BOTTOM_LEFT:
			return Vector2(0, node.size.y)
		RotationPivot.BOTTOM_CENTER:
			return Vector2(node.size.x / 2, node.size.y)
		RotationPivot.BOTTOM_RIGHT:
			return node.size
	return Vector2.ZERO
	
	
func _ready() -> void:
	if content:
		panel_container.add_child(content)
		
	set_background_color(background_color)
