class_name SSDMUIPulseScene
extends PanelContainer

@export var speed: float = 10.0
@export var duration: float = 0.0
@export var min_alpha: float = 0.2
@export var background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var animation_target: Control
@export var shader_material: ShaderMaterial

var animator: SSDMUIPulseAnimator


func set_min_alpha(new_min: float) -> void:
	animator.set_min_alpha(new_min)
	
	
func set_speed(new_speed) -> void:
	animator.set_speed(new_speed)
	
	
func set_duration(new_duration) -> void:
	animator.set_duration(new_duration)
	
	
func set_background_color(new_color: Color) -> void:
	animator.set_background_color(new_color)
	
	
func play() -> void:
	animator.play()
	
	
func stop() -> void:
	animator.stop()


func _ready() -> void:
	animator = SSDMUIPulseAnimator.new(animation_target, shader_material, SSDMUIGlobal.PULSE_SPEED, SSDMUIGlobal.PULSE_ENABLED, speed, background_color, duration)
	set_min_alpha(min_alpha)
