class_name SSDMUITextCrawlAnimator
extends Control

const SIZE: String = "size"
const SET_FIT_CONTENT: String = "set_fit_content"
const FIT_CONTENT: String = "fit_content"
const CRAWL_FADE_PIXELS: String = "fade_pixels"
const CRAWL_LABEL_POSITION_Y: String = "label_position_y"
const POSITION_Y: String = "position:y"
const CRAWL_VIEWPORT: String = "CrawlViewport"

@export var crawl_height: float
@export var speed: float
@export var crawl_fade_height: float
@export var shader_material: ShaderMaterial

@export_group("Controls")
@export var text_label: RichTextLabel

var _target_visible_chars: int = 0
var main_tween: Tween
var _crawl_viewport: Control  # Reference to created crawl viewport


func setup_crawl_effect() -> void:
	text_label.visible_characters = _target_visible_chars

	# Get content height (full text height)
	var content_height = text_label.get_content_height()
	if content_height <= 0:
		content_height = text_label.size.y
	if content_height <= 0:
		content_height = 100.0
		push_warning("SSDM-UI: crawl effect - using fallback content height")

	var original_parent = text_label.get_parent()

	# Create a clipping viewport container
	_crawl_viewport = Control.new()
	_crawl_viewport.name = CRAWL_VIEWPORT
	_crawl_viewport.clip_contents = true
	_crawl_viewport.custom_minimum_size.y = crawl_height
	_crawl_viewport.custom_minimum_size.x = 0
	_crawl_viewport.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	# 0 = shrink to beginning (default when SIZE_SHRINK_CENTER and SIZE_SHRINK_END not set)
	_crawl_viewport.size_flags_vertical = 0
	# Force size to not exceed minimum (prevent expansion)
	_crawl_viewport.set_deferred(SIZE, Vector2(0, crawl_height))

	# Get label's position in parent before reparenting
	var label_index = text_label.get_index()
	var label_size_flags_h = text_label.size_flags_horizontal

	# Insert viewport container where label was
	original_parent.add_child(_crawl_viewport)
	original_parent.move_child(_crawl_viewport, label_index)

	# Reparent label into viewport container
	text_label.reparent(_crawl_viewport)

	# Keep label's horizontal size flags for proper width in HBox
	_crawl_viewport.size_flags_horizontal = label_size_flags_h

	# Disable fit_content so the label doesn't try to size itself
	if text_label.has_method(SET_FIT_CONTENT):
		text_label.set_fit_content(false)
	elif FIT_CONTENT in text_label:
		text_label.fit_content = false

	# Configure label for absolute positioning within viewport
	text_label.anchor_top = 0.0
	text_label.anchor_bottom = 0.0
	text_label.anchor_left = 0.0
	text_label.anchor_right = 1.0
	text_label.offset_top = 0.0
	text_label.offset_bottom = content_height
	text_label.offset_left = 0.0
	text_label.offset_right = 0.0

	# Make sure label doesn't expand the viewport
	# 0 = shrink to beginning (default when SIZE_SHRINK_CENTER and SIZE_SHRINK_END not set)
	text_label.size_flags_vertical = 0

	# Start with text at bottom of viewport (Star Wars style - text enters from below)
	text_label.position.y = crawl_height

	# Calculate scroll distance: from bottom of viewport to all text exited top
	var scroll_distance = crawl_height + content_height

	# Calculate duration based on speed (pixels per second)
	var duration = scroll_distance / speed
	duration = max(duration, 1.0)

	# Set up shader for fade effect at top of viewport
	var fade_pixels = crawl_height * crawl_fade_height
	if shader_material and fade_pixels > 0.0:
		shader_material.set_shader_parameter(SSDMUISingleControlShaderAnimatorBase.SHADER_ENABLED, 1.0)
		shader_material.set_shader_parameter(CRAWL_FADE_PIXELS, fade_pixels)
		shader_material.set_shader_parameter(CRAWL_LABEL_POSITION_Y, crawl_height)

	# Animate label position scrolling up
	main_tween = text_label.create_tween()
	main_tween.set_parallel(true)

	# Tween the label's position
	main_tween.tween_property(
		text_label,
		POSITION_Y,
		-content_height,
		duration
	)

	# Tween the shader parameter in sync (for fade effect)
	if shader_material and fade_pixels > 0.0:
		main_tween.tween_property(
			shader_material,
			SSDMUISingleControlShaderAnimatorBase.SHADER_PARAMETER + CRAWL_LABEL_POSITION_Y,
			-content_height,
			duration
		)

	await main_tween.finished
	
	
func apply_shader() -> void:
	text_label.material = shader_material


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var text_content = text_label.get_parsed_text()
	var char_count = text_content.length()
	_target_visible_chars = char_count
	apply_shader()
	if main_tween:
		main_tween.kill()
	
	await setup_crawl_effect()
	"""# Show all characters immediately
	text_label.visible_characters = _target_visible_chars

	# Get content height (full text height)
	var content_height = text_label.get_content_height()
	if content_height <= 0:
		content_height = text_label.size.y
	if content_height <= 0:
		content_height = 100.0
		push_warning("SSDM-UI: crawl effect - using fallback content height")

	var viewport_height = crawl_height
	var original_parent = text_label.get_parent()

	clip_contents = true
	custom_minimum_size.y = viewport_height
	custom_minimum_size.x = 0
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	# 0 = shrink to beginning (default when SIZE_SHRINK_CENTER and SIZE_SHRINK_END not set)
	size_flags_vertical = 0
	# Force size to not exceed minimum (prevent expansion)
	set_deferred(SIZE, Vector2(0, viewport_height))

	# Get label's position in parent before reparenting
	var label_index = text_label.get_index()
	var label_size_flags_h = text_label.size_flags_horizontal

	# Keep label's horizontal size flags for proper width in HBox
	size_flags_horizontal = label_size_flags_h

	# Disable fit_content so the label doesn't try to size itself
	if text_label.has_method(SET_FIT_CONTENT):
		text_label.set_fit_content(false)
	elif FIT_CONTENT in text_label:
		text_label.fit_content = false

	# Configure label for absolute positioning within viewport
	text_label.anchor_top = 0.0
	text_label.anchor_bottom = 0.0
	text_label.anchor_left = 0.0
	text_label.anchor_right = 1.0
	text_label.offset_top = 0.0
	text_label.offset_bottom = content_height
	text_label.offset_left = 0.0
	text_label.offset_right = 0.0

	# Make sure label doesn't expand the viewport
	# 0 = shrink to beginning (default when SIZE_SHRINK_CENTER and SIZE_SHRINK_END not set)
	text_label.size_flags_vertical = 0

	# Start with text at bottom of viewport (Star Wars style - text enters from below)
	text_label.position.y = viewport_height

	# Calculate scroll distance: from bottom of viewport to all text exited top
	var scroll_distance = viewport_height + content_height

	# Calculate duration based on speed (pixels per second)
	var duration = scroll_distance / speed
	duration = max(duration, 1.0)

	# Set up shader for fade effect at top of viewport
	var fade_pixels = viewport_height * crawl_fade_height
	if shader_material and fade_pixels > 0.0:
		shader_material.set_shader_parameter(CRAWL_FADE_PIXELS, fade_pixels)
		shader_material.set_shader_parameter(CRAWL_LABEL_POSITION_Y, viewport_height)

	# Animate label position scrolling up
	main_tween = text_label.create_tween()
	main_tween.set_parallel(true)

	# Tween the label's position
	main_tween.tween_property(
		text_label,
		POSITION_Y,
		-content_height,
		duration
	)

	# Tween the shader parameter in sync (for fade effect)
	if shader_material and fade_pixels > 0.0:
		main_tween.tween_property(
			shader_material,
			SHADER_PARAMATER + CRAWL_LABEL_POSITION_Y,
			-content_height,
			duration
		)

	await main_tween.finished


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass"""
