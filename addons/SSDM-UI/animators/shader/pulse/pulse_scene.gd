class_name SSDMUIPulseScene
extends SSDMUIShaderSceneBase

@export var min_alpha: float = 0.2


func set_min_alpha(new_min: float) -> void:
	var pulse_animator: SSDMUIPulseAnimator = _animator
	pulse_animator.set_min_alpha(new_min)
	

func _ready() -> void:
	_animator = SSDMUIPulseAnimator.new(material_target, shader_material, SSDMUIGlobal.PULSE_SPEED, SSDMUIGlobal.PULSE_ENABLED, background_color, speed, duration)
	set_min_alpha(min_alpha)
