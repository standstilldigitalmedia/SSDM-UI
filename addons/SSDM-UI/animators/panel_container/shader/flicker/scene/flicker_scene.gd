class_name SSDMUIFlickerScene
extends PanelContainer

@export var min_alpha: float = 0.3
@export var speed: float = 10.0
@export var duration: float = 0.0
@export var background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var animation_target: Control
@export var shader_material: ShaderMaterial

var _animator: SSDMUIFlickerAnimator


func set_min_alpha(new_min: float) -> void:
	_animator.set_min_alpha(new_min)
	
	
func set_background_color(new_color: Color) -> void:
	_animator.set_background_color(new_color)
	
	
func set_speed(new_speed) -> void:
	_animator.set_speed(new_speed)
	
	
func set_duration(new_duration) -> void:
	_animator.set_duration(new_duration)
	
	
func play() -> void:
	_animator.play()
	
	
func stop() -> void:
	_animator.stop()


func _ready() -> void:
	_animator = SSDMUIFlickerAnimator.new(
		animation_target, 
		shader_material, 
		SSDMUIGlobal.FLICKER_SPEED, 
		SSDMUIGlobal.FLICKER_ENABLED, 
		speed,
		background_color,
		duration
	)
	_animator.set_min_alpha(min_alpha)
