class_name SSDMUIHueShiftScene
extends SSDMUIShaderSceneBase


func _ready() -> void:
	_animator = SSDMUIHueShiftAnimator.new(material_target, shader_material, SSDMUIGlobal.HUE_SHIFT_SPEED, SSDMUIGlobal.HUE_SHIFT_ENABLED, background_color, speed, duration)
