@abstract class_name SSDMUISingleControlShaderAnimatorBase
extends Control

const SHADER_PARAMETER: String = "shader_parameter/"
const SHADER_ENABLED: String = "shader_enabled"
const BACKGROUND_COLOR: String = "bg_color"
const SPEED: String = "speed"
const MIN_ALPHA: String = "min_alpha"
const PROGRESS: String = "progress"

@export var speed: float = 1.0  
@export var duration: float = 0.0 
@export var background_color: Color = Color(1,1,1,1)
@export var shader_material: ShaderMaterial


func set_speed(new_speed: float) -> void:
	shader_material.set_shader_parameter(SPEED, new_speed)
	
	
func set_duration(new_duration: float) -> void:
	duration = new_duration
	
	
func set_background_color(new_background_color: Color) -> void:
	shader_material.set_shader_parameter(BACKGROUND_COLOR, new_background_color)
	

func play() -> void:
	_enable_shader()
	_create_timeout_timer(duration)	
	
	
func stop() -> void:
	_disable_shader()
	
	
func _init_shader_paramaters() -> void:
	set_background_color(background_color)
	set_speed(speed)
	
	
func _enable_shader() -> void:
	shader_material.set_shader_parameter(SHADER_ENABLED, 1.0)
	
	
func _disable_shader() -> void:
	shader_material.set_shader_parameter(SHADER_ENABLED, 0.0)
	
	
func _apply_shader() -> void:
	material = shader_material
	
	
func _create_timeout_timer(duration: float) -> void:
	if duration > 0.0:
		var timer: Timer = Timer.new()	
		timer.one_shot = true
		timer.wait_time = duration
		timer.timeout.connect(stop)
		add_child(timer)
		timer.start()
	
	
func _ready() -> void:
	_apply_shader()
	_init_shader_paramaters()
