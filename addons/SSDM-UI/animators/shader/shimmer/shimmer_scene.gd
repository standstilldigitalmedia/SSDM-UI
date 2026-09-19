class_name SSDMUIShimmerScene
extends SSDMUIShaderSceneBase

@export var width: float = 0.2 
@export var brightness: float = 0.5 


func set_width(new_width: float) -> void:
	_animator.set_width(new_width)
	

func set_brightness(new_brightness: float) -> void:
	_animator.set_brightness(new_brightness)


func _ready() -> void:
	_animator = SSDMUIShimmerAnimator.new(material_target, shader_material, SSDMUIGlobal.SHIMMER_SPEED, SSDMUIGlobal.SHIMMER_ENABLED, background_color, speed, duration)
	_animator.set_brightness(brightness)
	_animator.set_width(width)
