class_name SSDMUIColorScene
extends SSDMUITweenedShaderSceneBase

@export var to_color: Color = Color(0.0,0.0,0.0,1.0)


func set_to_color(new_to_color: Color) -> void:
	_animator.set_tween_to(new_to_color)
	
	
func set_background_color(new_background_color: Color) -> void:
	_animator.set_tween_from(new_background_color)
	super(new_background_color)
	
	
func _ready() -> void:
	_animator = SSDMUIColorAnimator.new()
	_animator.init_shader(material_target, shader_material, "", SSDMUIGlobal.COLOR_ENABLED, background_color, speed, duration)
	_animator.init_tween(shader_material, SSDMUIGlobal.SHADER_PARAMETER + SSDMUIGlobal.BACKGROUND_COLOR, background_color, to_color, duration, self, transition_type, ease_type_play, ease_type_reverse)
