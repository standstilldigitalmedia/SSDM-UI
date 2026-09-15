class_name SSDMUIDissolveScene
extends SSDMUITweenedShaderSceneBase

@export var mode: SSDMUIGlobal.Mode = SSDMUIGlobal.Mode.NOISE
@export var spread: float = 0.1


func set_mode(new_mode: SSDMUIGlobal.Mode) -> void:
	_animator.set_mode(new_mode)


func set_spread(new_spread: float) -> void:
	_animator.set_spread(new_spread)
	
	
func _ready() -> void:
	_animator = SSDMUIDissolveAnimator.new(shader_material, self, shader_material, speed, background_color, animation_target, transition_type, ease_type_play, ease_type_reverse, duration, false)
	_animator.set_mode(mode)
	_animator.set_spread(spread)
