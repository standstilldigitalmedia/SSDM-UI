class_name SSDMUIHueShiftScene
extends PanelContainer

@export var speed: float = 1.0
@export var duration: float = 0.0
@export var background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var animation_target: Control
@export var shader_material: ShaderMaterial

var _animator: SSDMUIControlHueShiftAnimator


func set_speed(new_speed) -> void:
	_animator.set_speed(new_speed)
	
	
func set_duration(new_duration) -> void:
	_animator.set_duration(new_duration)
	
	
func set_background_color(new_color: Color) -> void:
	_animator.set_background_color(new_color)
	
	
func play() -> void:
	_animator.play()
	
	
func stop() -> void:
	_animator.stop()


func _ready() -> void:
	_animator = SSDMUIControlHueShiftAnimator.new(animation_target, shader_material, SSDMUIGlobal.HUE_SHIFT_SPEED, SSDMUIGlobal.HUE_SHIFT_ENABLED, speed, background_color, duration)
