class_name SSDMUIShimmerScene
extends PanelContainer

@export var shimmer_speed: float = 1.0
@export var shimmer_duration: float = 0.0
@export var shimmer_width: float = 0.2 
@export var shimmer_brightness: float = 0.5 
@export var shimmer_background_color: Color = Color(1.0,1.0,1.0,1.0)

@export_group("Controls")
@export var animation_target: Control
@export var shader_material: ShaderMaterial

var shimmer_animator: SSDMUIControlShimmerAnimator


func set_width(new_width: float) -> void:
	shimmer_animator.set_width(new_width)
	

func set_brightness(new_brightness: float) -> void:
	shimmer_animator.set_brightness(new_brightness)
	
	
func set_speed(new_speed) -> void:
	shimmer_animator.set_speed(new_speed)
	
	
func set_duration(new_duration) -> void:
	shimmer_animator.set_duration(new_duration)
	
	
func set_background_color(new_color: Color) -> void:
	shimmer_animator.set_background_color(new_color)
	
	
func play() -> void:
	shimmer_animator.play()
	
	
func stop() -> void:
	shimmer_animator.stop()


func _ready() -> void:
	shimmer_animator = SSDMUIControlShimmerAnimator.new(animation_target, shader_material)
	set_speed(shimmer_speed)
	set_duration(shimmer_duration)
	set_background_color(shimmer_background_color)
