class_name SSDMUITextApparateAnimator
extends SSDMUISingleControlTweenedShaderAnimatorBase

const APPARATE_SPREAD: String = "apparate_spread"

@export var spread: float = 1.0  ## Width of the fade gradient. Higher = softer transition.

@export_group("Controls")
@export var text_label: RichTextLabel


func set_spread(new_spread: float) -> void:
	shader_material.set_shader_parameter(APPARATE_SPREAD, new_spread)
	

func _init_text_label() -> void:
	var text_content = text_label.get_parsed_text()
	var char_count = text_content.length()
	text_label.visible_characters = char_count
	
	
func _tween_forward() -> void:
	_init_text_label()
	var end_progress = 1.0 + spread
	var apparate_duration = end_progress / speed
	_main_tween.tween_property(shader_material, SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + SSDMUISingleControlShaderAnimatorBase.PROGRESS, end_progress, apparate_duration)
	await _main_tween.finished
	
	
func _tween_reverse() -> void:
	pass
	
	
func _init_shader_paramaters() -> void:
	super()
	shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.PROGRESS, 0.0)
	shader_material.set_shader_parameter(APPARATE_SPREAD, spread)
	
	
func _ready() -> void:
	super()
	play()
	
	
