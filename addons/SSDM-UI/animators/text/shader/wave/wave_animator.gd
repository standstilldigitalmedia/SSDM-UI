extends RichTextLabel

const AMPLITUDE: String = "amplitude"
const FREQUENCY: String = "frequency"
const HORIZONTAL: String = "horizontal"

@export var speed: float = 3.0
@export var amplitude: float = 0.03
@export var frequency: float = 10.0
@export var horizontal: float = 0.0
@export var shader_material: ShaderMaterial

var _main_tween: Tween


func _set_shader_properties() -> void:
	shader_material.set_shader_parameter(AMPLITUDE, amplitude)
	shader_material.set_shader_parameter(FREQUENCY, frequency)
	shader_material.set_shader_parameter(HORIZONTAL, horizontal)
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.SHADER_ENABLED, 1.0)
	
	
func _kill_tween() -> void:
	if _main_tween:
		_main_tween.kill()
		

func _apply_shader() -> void:
	material = shader_material
	
	
func _ready() -> void:
	_apply_shader()
	_kill_tween()
	_set_shader_properties()
