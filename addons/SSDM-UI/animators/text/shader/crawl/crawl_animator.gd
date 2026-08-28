class_name SSDMUITextCrawlAnimator
extends Control

const SIZE: String = "size"
const SET_FIT_CONTENT: String = "set_fit_content"
const FIT_CONTENT: String = "fit_content"
const CRAWL_FADE_PIXELS: String = "fade_pixels"
const CRAWL_LABEL_POSITION_Y: String = "label_position_y"
const POSITION_Y: String = "position:y"
const CRAWL_VIEWPORT: String = "CrawlViewport"
const FALLBACK_CONTENT_HEIGHT: float = 100.0

@export_multiline var label_text: String
@export var speed: float = 75.0
@export var viewport_width: float = 200.0
@export var viewport_height: float = 200.0
@export var fade_height: float = 2.0
@export var shader_material: ShaderMaterial

@export_group("Controls")
@export var crawl_viewport: Control  
@export var text_label: RichTextLabel

var _target_visible_chars: int = 0
var _main_tween: Tween
var _content_height: float = FALLBACK_CONTENT_HEIGHT
var _duration: float = 0.0
var _fade_pixels = viewport_height * fade_height


func _get_content_height() -> float:
	if text_label.get_content_height() <= 0:
		return text_label.size.y
	push_warning("SSDM-UI: crawl effect - using fallback content height")
	return FALLBACK_CONTENT_HEIGHT
		
	
func _apply_shader() -> void:
	text_label.material = shader_material
	
	
func _setup_text_label() -> void:
	text_label.text = label_text
	var text_content = text_label.get_parsed_text()
	var char_count = text_content.length()
	_target_visible_chars = char_count
	text_label.visible_characters = _target_visible_chars
	
	
func _setup_viewport() -> void:
	crawl_viewport.clip_contents = true
	crawl_viewport.custom_minimum_size.y = viewport_height
	crawl_viewport.custom_minimum_size.x = viewport_width
	crawl_viewport.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	# 0 = shrink to beginning (default when SIZE_SHRINK_CENTER and SIZE_SHRINK_END not set)
	crawl_viewport.size_flags_vertical = 0
	# Force size to not exceed minimum (prevent expansion)
	crawl_viewport.set_deferred(SIZE, Vector2(0, viewport_height))
	crawl_viewport.size_flags_horizontal = text_label.size_flags_horizontal
	
	
func _setup_label_anchors() -> void:
	text_label.anchor_top = 0.0
	text_label.anchor_bottom = 0.0
	text_label.anchor_left = 0.0
	text_label.anchor_right = 1.0
	
	
func _setup_label_offsets() -> void:
	text_label.offset_top = 0.0
	text_label.offset_bottom = _content_height
	text_label.offset_left = 0.0
	text_label.offset_right = 0.0
	
	
func _setup_shader_paramaters() -> void:
	if shader_material and _fade_pixels > 0.0:
		shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.SHADER_ENABLED, 1.0)
		shader_material.set_shader_parameter(CRAWL_FADE_PIXELS, _fade_pixels)
		shader_material.set_shader_parameter(CRAWL_LABEL_POSITION_Y, viewport_height)
	

func _setup_main_tween() -> void:
	_main_tween = text_label.create_tween()
	_main_tween.set_parallel(true)
		
		
func _get_duration() -> float:
	var scroll_distance = viewport_height + _content_height
	var duration = scroll_distance / speed
	return max(duration, 1.0)
	
	
func _disable_fit_content() -> void:
	if text_label.has_method(SET_FIT_CONTENT):
		text_label.set_fit_content(false)
	elif FIT_CONTENT in text_label:
		text_label.fit_content = false
		
		
func _adjust_text_label() -> void:
	text_label.size_flags_vertical = 0
	text_label.position.y = viewport_height
	text_label.custom_minimum_size.x = viewport_width
	
	
func _kill_tween() -> void:
	if _main_tween:
		_main_tween.kill()
		
		
func _tween_label_position() -> void:
	_main_tween.tween_property(
		text_label,
		POSITION_Y,
		-_content_height,
		_duration
	)


func _tween_shader_paramater() -> void:
	if shader_material and _fade_pixels > 0.0:
		_main_tween.tween_property(
			shader_material,
			SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + CRAWL_LABEL_POSITION_Y,
			-_content_height,
			_duration
		)	
		
		
func setup_crawl_effect() -> void:
	_setup_text_label()
	_apply_shader()
	_kill_tween()
	_setup_viewport()
	_disable_fit_content()
	_setup_label_anchors()
	_content_height = _get_content_height()
	_setup_label_offsets()
	_adjust_text_label()
	_duration = _get_duration()
	_fade_pixels = viewport_height * fade_height
	_setup_shader_paramaters()
	_setup_main_tween()
	_tween_label_position()
	_tween_shader_paramater()
	await _main_tween.finished


func _ready() -> void:	
	await setup_crawl_effect()
