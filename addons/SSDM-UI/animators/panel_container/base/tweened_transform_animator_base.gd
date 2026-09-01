@abstract class_name SSDMUISingleControlTweenedTransformAnimatorBase
extends SSDMUISingleControlTweenAnimatorBase

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

const PANEL_THEME: String = "panel"

@export var background_color: Color = Color(1,1,1,1)

@export_group("Controls")
@export var content: Control
@export var panel_container: PanelContainer


func set_background_color(new_color: Color) -> void:
	var new_style_box: StyleBox = panel_container.get_theme_stylebox(PANEL_THEME)
	new_style_box.bg_color = new_color
	
	
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
		await content.get_tree().process_frame
		content.reparent(panel_container)
	set_background_color(background_color)
