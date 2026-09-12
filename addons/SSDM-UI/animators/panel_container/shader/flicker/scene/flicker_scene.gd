class_name SSDMUIFlickerScene
extends PanelContainer

@export var flicker_min_alpha: float = 0.3
@export var flicker_speed: float = 10.0
@export var flicker_duration: float = 0.0
@export var flicker_background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var animation_target: Control
@export var shader_material: ShaderMaterial

var flicker_animator: SSDMUIControlFlickerAnimator


func set_min_alpha(new_min: float) -> void:
	flicker_animator.set_min_alpha(new_min)


func set_speed(new_speed) -> void:
	flicker_animator.set_speed(new_speed)
	
	
func set_duration(new_duration) -> void:
	flicker_animator.set_duration(new_duration)
	
	
func set_background_color(new_color: Color) -> void:
	flicker_animator.set_background_color(new_color)
	
	
func play() -> void:
	flicker_animator.play()
	
	
func stop() -> void:
	flicker_animator.stop()


func _ready() -> void:
	flicker_animator = SSDMUIControlFlickerAnimator.new(animation_target, shader_material)
	set_min_alpha(flicker_min_alpha)
	set_speed(flicker_speed)
	set_duration(flicker_duration)
	set_background_color(flicker_background_color)
