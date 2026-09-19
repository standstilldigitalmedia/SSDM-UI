class_name SSDMUIDissolveScene
extends SSDMUITweenedShaderSceneBase

@export var mode: SSDMUIGlobal.Mode = SSDMUIGlobal.Mode.NOISE
@export var spread: float = 0.1


func set_mode(new_mode: SSDMUIGlobal.Mode) -> void:
	_animator.set_mode(new_mode)


func set_spread(new_spread: float) -> void:
	_animator.set_spread(new_spread)
	
	
func _ready() -> void:
	_animator = SSDMUIDissolveAnimator.new()
	_animator.init_shader(material_target, shader_material, "", SSDMUIGlobal.DISSOLVE_ENABLED, background_color, speed, duration)
	_animator.init_tween(shader_material, SSDMUIGlobal.SHADER_PARAMETER + SSDMUIGlobal.DISSOLVE_PROGRESS, 1.0, 0.0, duration, self, transition_type, ease_type_play, ease_type_reverse)
	_animator.set_mode(mode)
	_animator.set_spread(spread)
