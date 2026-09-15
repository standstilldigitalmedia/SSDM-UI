class_name SSDMUITransformAnimatorBase
extends SSDMUITweenAnimatorBase

var background_color: Color = Color(1,1,1,1)
var content: Control
var panel_container: PanelContainer


func set_background_color(new_background_color: Color) -> void:
	var new_style_box: StyleBox = panel_container.get_theme_stylebox(SSDMUIGlobal.PANEL_THEME)
	new_style_box.bg_color = new_background_color
	background_color = new_background_color
	
	
func set_content(new_content: Control) -> void:
	content = new_content
	await content.get_tree().process_frame
	content.reparent(panel_container)
	
	
func set_panel_container(new_panel_container: PanelContainer) -> void:
	panel_container = new_panel_container
		

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
