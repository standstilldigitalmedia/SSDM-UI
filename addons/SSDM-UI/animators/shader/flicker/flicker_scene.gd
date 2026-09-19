class_name SSDMUIFlickerScene
extends SSDMUIShaderSceneBase

@export var min_alpha: float = 0.3


func set_min_alpha(new_min: float) -> void:
	var flicker_animator: SSDMUIFlickerAnimator = _animator
	flicker_animator.set_min_alpha(new_min)


func _ready() -> void:
	_animator = SSDMUIFlickerAnimator.new(material_target, shader_material, SSDMUIGlobal.FLICKER_SPEED, SSDMUIGlobal.FLICKER_ENABLED, background_color, speed, duration)
	_animator.set_min_alpha(min_alpha)
