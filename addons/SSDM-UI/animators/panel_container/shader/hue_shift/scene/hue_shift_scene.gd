class_name SSDMUIHueShiftScene
extends PanelContainer

@export var hue_shift_speed: float = 1.0
@export var hue_shift_duration: float = 0.0
@export var hue_shift_background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var animation_target: Control
@export var shader_material: ShaderMaterial

var hue_shift_animator: SSDMUIControlHueShiftAnimator


func set_speed(new_speed) -> void:
	hue_shift_animator.set_speed(new_speed)
	
	
func set_duration(new_duration) -> void:
	hue_shift_animator.set_duration(new_duration)
	
	
func set_background_color(new_color: Color) -> void:
	hue_shift_animator.set_background_color(new_color)
	
	
func play() -> void:
	hue_shift_animator.play()
	
	
func stop() -> void:
	hue_shift_animator.stop()


func _ready() -> void:
	hue_shift_animator = SSDMUIControlHueShiftAnimator.new(animation_target, shader_material)
	set_speed(hue_shift_speed)
	set_duration(hue_shift_duration)
	set_background_color(hue_shift_background_color)
