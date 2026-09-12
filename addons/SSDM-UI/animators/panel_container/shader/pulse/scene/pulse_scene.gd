class_name SSDMUIPulseScene
extends PanelContainer

@export var pulse_speed: float = 10.0
@export var pulse_duration: float = 0.0
@export var pulse_min_alpha: float = 0.2
@export var pulse_background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var animation_target: Control
@export var shader_material: ShaderMaterial

var pulse_animator: SSDMUIControlPulseAnimator


func set_min_alpha(new_min: float) -> void:
	pulse_animator.set_min_alpha(new_min)
	
	
func set_speed(new_speed) -> void:
	pulse_animator.set_speed(new_speed)
	
	
func set_duration(new_duration) -> void:
	pulse_animator.set_duration(new_duration)
	
	
func set_background_color(new_color: Color) -> void:
	pulse_animator.set_background_color(new_color)
	
	
func play() -> void:
	pulse_animator.play()
	
	
func stop() -> void:
	pulse_animator.stop()


func _ready() -> void:
	pulse_animator = SSDMUIControlPulseAnimator.new(animation_target, shader_material)
	set_speed(pulse_speed)
	set_duration(pulse_duration)
	set_min_alpha(pulse_min_alpha)
	set_background_color(pulse_background_color)
