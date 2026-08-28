extends RichTextLabel

const APPARATE_PROGRESS: String = "apparate_progress"
const APPARATE_SPREAD: String = "apparate_spread"
const SHADER_PARAMATER: String = "shader_parameter/"

@export var speed: float = 0.7
@export var apparate_spread: float = 1.0  ## Width of the fade gradient. Higher = softer transition.
@export var shader_material: ShaderMaterial

var _main_tween: Tween

func _apply_shader() -> void:
	material = shader_material
	
	
func _ready() -> void:
	_apply_shader()
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.SHADER_ENABLED, 1.0)
	shader_material.set_shader_parameter(APPARATE_PROGRESS, 0.0)
	shader_material.set_shader_parameter(APPARATE_SPREAD, apparate_spread)
	
	
	var text_content = get_parsed_text()
	var char_count = text_content.length()
	visible_characters = char_count

	# Tween progress to 1.0 + spread so fade band clears the right edge completely
	_main_tween = create_tween()
	var end_progress = 1.0 + apparate_spread
	var apparate_duration = end_progress / speed
	_main_tween.tween_property(shader_material, SHADER_PARAMATER + APPARATE_PROGRESS, end_progress, apparate_duration)
	await _main_tween.finished
