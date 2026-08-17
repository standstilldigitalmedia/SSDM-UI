## Animates RichTextLabel nodes with typewriter, apparate, wave, shake, glitch, rainbow, pulse, and crawl effects.[br]
## Can be used standalone for dialogue systems, RPG text, or any text animation needs.[br][br]
##
## Dependencies: SSDMTextAnimatorConfig only.[br]
## Created by passing a RichTextLabel to the constructor, then configure() and play().
class_name SSDMTextAnimator
extends RefCounted

signal finished  ## Emitted when play() or reverse() completes. Use to await parallel animations.

const TEXT_EFFECTS_SHADER_FILE: String = "../shader/text_effects.gdshader"
const VISIBLE_CHARACTERS: String = "visible_characters"
const SET_FIT_CONTENT: String = "set_fit_content"
const FIT_CONTENT: String = "fit_content"
const POSITION_Y: String = "position:y"

const SHADER_PARAMATER: String = "shader_parameter/"

const APPARATE_ENABLED: String = "apparate_enabled"
const APPARATE_PROGRESS: String = "apparate_progress"
const APPARATE_SPREAD: String = "apparate_spread"

const WAVE_ENABLED: String = "wave_enabled"
const WAVE_HORIZONTAL: String = "wave_horizontal"
const WAVE_AMPLITUDE: String = "wave_amplitude"
const WAVE_FREQUENCY: String = "wave_frequency"
const WAVE_SPEED: String = "wave_speed"

const SHAKE_ENABLED: String = "shake_enabled"
const SHAKE_AMOUNT: String = "shake_amount"
const SHAKE_SPEED: String = "shake_speed"
		
const GLITCH_ENABLED: String = "glitch_enabled"
const GLITCH_INTENSITY: String = "glitch_intensity"
const GLITCH_SPEED: String = "glitch_speed"
const GLITCH_BLOCK_SIZE: String = "glitch_block_size"
const GLITCH_COLOR_DRIFT: String = "glitch_color_drift"
		
const RAINBOW_ENABLED: String = "rainbow_enabled"
const RAINBOW_FREQUENCY: String = "rainbow_frequency"
const RAINBOW_SPEED: String = "rainbow_speed"
const RAINBOW_SATURATION: String = "rainbow_saturation"

const PULSE_ENABLED: String = "pulse_enabled"
const PULSE_SPEED: String = "pulse_speed"
const PULSE_MIN_ALPHA: String = "pulse_min_alpha"

const CRAWL_ENABLED: String = "crawl_enabled"
const CRAWL_VIEWPORT: String = "CrawlViewport"
const CRAWL_FADE_PIXELS: String = "crawl_fade_pixels"
const CRAWL_LABEL_POSITION_Y: String = "crawl_label_position_y"

const SCALE_PROPERTY: String = "scale"
const ROTATION_PROPERTY: String = "rotation"
const POSITION_PROPERTY: String = "position"
const MODULATE_A_PROPERTY: String = "modulate:a"

var text_label: RichTextLabel
var config: SSDMTextAnimatorConfig
var text_tween: Tween
var transform_tween: Tween
var wave_fade_tween: Tween
var shake_fade_tween: Tween
var glitch_fade_tween: Tween
var text_shader_material: ShaderMaterial
var _original_label_material: Material
var _target_visible_chars: int = 0
var _crawl_viewport: Control  # Reference to created crawl viewport
var _delay_before: float = 0.0  ## Delay before playing (builder pattern)


## Configures the text animator with animation parameters.[br][br]
##
## @param cfg - The text animator configuration resource[br]
## @return This animator instance for method chaining[br]
func configure(cfg: SSDMTextAnimatorConfig) -> SSDMTextAnimator:
	config = cfg
	return self


# =============================================================================
# BUILDER PATTERN METHODS
# =============================================================================
# These methods allow fluent animation building without config files:
#   SSDMTextAnimator.new(label).rainbow().wave().play()

## Ensures a config exists, creating one if needed.[br][br]
func _ensure_config() -> void:
	if not config:
		config = SSDMTextAnimatorConfig.new()


# --- Text Reveal Effects ---

## Enables typewriter effect (character by character reveal).[br][br]
func typewriter(chars_per_second: float = 30.0, skip_on_click: bool = true) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_typewriter = true
	config.characters_per_second = chars_per_second
	config.skip_on_click = skip_on_click
	return self


## Enables apparate effect (mystical scattered fade).[br][br]
func apparate(speed: float = 0.7, spread: float = 1.0) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_text_apparate = true
	config.apparate_speed = speed
	config.apparate_spread = spread
	return self


## Enables crawl effect (Star Wars style scrolling).[br][br]
func crawl(height: float = 72.0, speed: float = 30.0, fade_height: float = 0.3) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_text_crawl = true
	config.crawl_height = height
	config.crawl_speed = speed
	config.crawl_fade_height = fade_height
	return self


# --- Continuous Shader Effects ---

## Enables wave effect (text undulation).[br][br]
func wave(amplitude: float = 0.03, frequency: float = 10.0, speed: float = 3.0, horizontal: bool = false) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_text_wave = true
	config.wave_amplitude = amplitude
	config.wave_frequency = frequency
	config.wave_speed = speed
	config.wave_horizontal = horizontal
	return self


## Enables shake effect (text jitter).[br][br]
func shake(amount: float = 0.02, speed: float = 20.0) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_text_shake = true
	config.text_shake_amount = amount
	config.text_shake_speed = speed
	return self


## Enables glitch effect (digital corruption).[br][br]
func glitch(intensity: float = 0.5, speed: float = 5.0, block_size: float = 0.1, color_drift: float = 0.02) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_text_glitch = true
	config.glitch_intensity = intensity
	config.glitch_speed = speed
	config.glitch_block_size = block_size
	config.glitch_color_drift = color_drift
	return self


## Enables rainbow effect (color cycling).[br][br]
func rainbow(frequency: float = 1.0, speed: float = 1.0, saturation: float = 1.0) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_text_rainbow = true
	config.rainbow_frequency = frequency
	config.rainbow_speed = speed
	config.rainbow_saturation = saturation
	return self


## Enables pulse effect (rhythmic fading).[br][br]
func pulse(speed: float = 2.0, min_alpha: float = 0.3) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_text_pulse = true
	config.pulse_speed = speed
	config.pulse_min_alpha = min_alpha
	return self


# --- Transform Animations ---

## Enables scale animation.[br][br]
func scale(from: Vector2 = Vector2(0.1, 0.1), to: Vector2 = Vector2.ONE, pivot: SSDMGlobal.RotationPivot = SSDMGlobal.RotationPivot.CENTER) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_scale = true
	config.scale_from = from
	config.scale_to = to
	config.scale_pivot_preset = pivot
	return self


## Enables rotation animation.[br][br]
func rotation(from_degrees: float = 0.0, to_degrees: float = 360.0, pivot: SSDMGlobal.RotationPivot = SSDMGlobal.RotationPivot.CENTER) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_rotation = true
	config.rotation_from_degrees = from_degrees
	config.rotation_to_degrees = to_degrees
	config.rotation_pivot_preset = pivot
	return self


## Enables position animation (slide from offset to zero).[br][br]
func position(offset: Vector2 = Vector2(20.0, 20.0)) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_position = true
	config.position_offset = offset
	return self


## Enables fade animation.[br][br]
func fade(from: float = 0.0, to: float = 1.0) -> SSDMTextAnimator:
	_ensure_config()
	config.animate_fade = true
	config.fade_from = from
	config.fade_to = to
	return self


# --- Timing and Easing ---

## Sets a delay before the animation starts.[br][br]
func delay(seconds: float) -> SSDMTextAnimator:
	_delay_before = seconds
	return self


## Sets the animation duration in seconds (for transform effects).[br][br]
func duration(seconds: float) -> SSDMTextAnimator:
	_ensure_config()
	config.animation_speed = seconds
	return self


## Sets the easing type.[br][br]
func ease(type: Tween.EaseType) -> SSDMTextAnimator:
	_ensure_config()
	config.ease_type = type
	return self


## Sets the transition type (curve shape).[br][br]
func transition(type: Tween.TransitionType) -> SSDMTextAnimator:
	_ensure_config()
	config.transition_type = type
	return self


# =============================================================================
# END BUILDER PATTERN METHODS
# =============================================================================


## Returns true if any text animations are configured.[br][br]
##
## @return True if any text effect is enabled[br]
func _has_text_animations() -> bool:
	return (config.animate_typewriter or
			config.animate_text_apparate or
			config.animate_text_crawl or
			_has_continuous_text_effects())


## Returns true if any continuous shader effects are configured.[br][br]
##
## @return True if wave, shake, glitch, rainbow, or pulse is enabled[br]
func _has_continuous_text_effects() -> bool:
	return (config.animate_text_wave or
			config.animate_text_shake or
			config.animate_text_glitch or
			config.animate_text_rainbow or
			config.animate_text_pulse)


## Returns true if any transform animations are configured.[br][br]
func _has_transform_animations() -> bool:
	return (config.animate_scale or
			config.animate_rotation or
			config.animate_position or
			config.animate_fade)


## Calculates the pivot offset for scale/rotation based on the configured preset.[br][br]
func _get_pivot_offset(node: Control, preset: SSDMGlobal.RotationPivot) -> Vector2:
	match preset:
		SSDMGlobal.RotationPivot.TOP_LEFT:
			return Vector2.ZERO
		SSDMGlobal.RotationPivot.TOP_CENTER:
			return Vector2(node.size.x / 2, 0)
		SSDMGlobal.RotationPivot.TOP_RIGHT:
			return Vector2(node.size.x, 0)
		SSDMGlobal.RotationPivot.CENTER_LEFT:
			return Vector2(0, node.size.y / 2)
		SSDMGlobal.RotationPivot.CENTER:
			return node.size / 2
		SSDMGlobal.RotationPivot.CENTER_RIGHT:
			return Vector2(node.size.x, node.size.y / 2)
		SSDMGlobal.RotationPivot.BOTTOM_LEFT:
			return Vector2(0, node.size.y)
		SSDMGlobal.RotationPivot.BOTTOM_CENTER:
			return Vector2(node.size.x / 2, node.size.y)
		SSDMGlobal.RotationPivot.BOTTOM_RIGHT:
			return node.size
	return Vector2.ZERO


## Plays transform animations (scale, rotation, position, fade).[br][br]
func _play_transforms() -> void:
	if not text_label or not config:
		return

	if transform_tween:
		transform_tween.kill()

	# Set initial states
	if config.animate_scale:
		text_label.scale = config.scale_from
		text_label.pivot_offset = _get_pivot_offset(text_label, config.scale_pivot_preset)
	if config.animate_rotation:
		text_label.rotation = deg_to_rad(config.rotation_from_degrees)
		text_label.pivot_offset = _get_pivot_offset(text_label, config.rotation_pivot_preset)
	if config.animate_position:
		text_label.position = config.position_offset
	if config.animate_fade:
		text_label.modulate.a = config.fade_from

	transform_tween = text_label.create_tween()
	transform_tween.set_parallel(true)
	transform_tween.set_ease(config.ease_type)
	transform_tween.set_trans(config.transition_type)

	if config.animate_scale:
		transform_tween.tween_property(text_label, SCALE_PROPERTY, config.scale_to, config.animation_speed)
	if config.animate_rotation:
		var to_radians = deg_to_rad(config.rotation_to_degrees)
		if config.rotation_to_degrees == 360.0 and config.rotation_from_degrees == 0.0:
			to_radians = TAU
		transform_tween.tween_property(text_label, ROTATION_PROPERTY, to_radians, config.animation_speed)
	if config.animate_position:
		transform_tween.tween_property(text_label, POSITION_PROPERTY, Vector2.ZERO, config.animation_speed)
	if config.animate_fade:
		transform_tween.tween_property(text_label, MODULATE_A_PROPERTY, config.fade_to, config.animation_speed)


## Reverses transform animations (scale, rotation, position, fade).[br][br]
func _reverse_transforms() -> void:
	if not text_label or not config:
		return

	if transform_tween:
		transform_tween.kill()

	transform_tween = text_label.create_tween()
	transform_tween.set_parallel(true)
	transform_tween.set_ease(config.ease_type)
	transform_tween.set_trans(config.transition_type)

	if config.animate_scale:
		transform_tween.tween_property(text_label, SCALE_PROPERTY, config.scale_from, config.animation_speed)
	if config.animate_rotation:
		var from_radians = deg_to_rad(config.rotation_from_degrees)
		transform_tween.tween_property(text_label, ROTATION_PROPERTY, from_radians, config.animation_speed)
	if config.animate_position:
		transform_tween.tween_property(text_label, POSITION_PROPERTY, config.position_offset, config.animation_speed)
	if config.animate_fade:
		transform_tween.tween_property(text_label, MODULATE_A_PROPERTY, config.fade_from, config.animation_speed)


## Plays the configured text animations.[br][br]
##
## @param duration - Duration for continuous effects (0 = plays indefinitely until interrupted)[br]
func play(duration: float = 0.0) -> void:
	if not text_label or not config:
		finished.emit()
		return

	# Handle delay from builder pattern
	if _delay_before > 0.0:
		await text_label.get_tree().create_timer(_delay_before).timeout
		_delay_before = 0.0  # Reset for potential reuse

	var has_text = _has_text_animations()
	var has_transform = _has_transform_animations()

	if not has_text and not has_transform:
		finished.emit()
		return

	var text_content = text_label.get_parsed_text()
	var char_count = text_content.length()
	_target_visible_chars = char_count

	# Start transform animations if configured
	if has_transform:
		_play_transforms()

	# If no text animations, just wait for transforms
	if not has_text or char_count == 0:
		if transform_tween:
			await transform_tween.finished
		finished.emit()
		return

	# Apply shader if any shader-based effects are enabled
	var needs_shader = (config.animate_text_apparate or
			config.animate_text_crawl or
			_has_continuous_text_effects())
	if needs_shader:
		_apply_text_shader()
		_setup_continuous_effects(duration)

	# Set up tween for one-time animations
	if text_tween:
		text_tween.kill()

	if config.animate_typewriter:
		# Typewriter: reveal characters at a constant rate
		text_label.visible_characters = 0
		text_tween = text_label.create_tween()
		var type_duration = char_count / config.characters_per_second
		text_tween.tween_property(text_label, VISIBLE_CHARACTERS, char_count, type_duration)
		await text_tween.finished

	elif config.animate_text_apparate:
		# Apparate: shader-based mystical scattered fade effect
		text_shader_material.set_shader_parameter(APPARATE_ENABLED, 1.0)
		text_shader_material.set_shader_parameter(APPARATE_PROGRESS, 0.0)
		text_shader_material.set_shader_parameter(APPARATE_SPREAD, config.apparate_spread)

		# Show all characters immediately - shader handles the fade
		text_label.visible_characters = char_count

		# Tween progress to 1.0 + spread so fade band clears the right edge completely
		text_tween = text_label.create_tween()
		var end_progress = 1.0 + config.apparate_spread
		var apparate_duration = end_progress / config.apparate_speed
		text_tween.tween_property(text_shader_material, SHADER_PARAMATER + APPARATE_PROGRESS, end_progress, apparate_duration)
		await text_tween.finished

	elif config.animate_text_crawl:
		# Crawl: Star Wars style scrolling text
		await _setup_crawl_effect()

	else:
		# No one-time animation, just show all characters for continuous effects
		text_label.visible_characters = char_count
		# For continuous-only effects with duration, wait for the duration
		if duration > 0.0 and _has_continuous_text_effects():
			await text_label.get_tree().create_timer(duration).timeout

	finished.emit()


## Reverses the text animation (for typewriter/apparate).[br]
## For continuous effects, this stops them.[br][br]
func reverse() -> void:
	if not text_label or not config:
		finished.emit()
		return

	# Handle delay from builder pattern
	if _delay_before > 0.0:
		await text_label.get_tree().create_timer(_delay_before).timeout
		_delay_before = 0.0  # Reset for potential reuse

	# Get shader material from label if we don't have a reference
	# (happens when reverse() is called on a fresh animator instance)
	if not text_shader_material and text_label.material is ShaderMaterial:
		text_shader_material = text_label.material

	# Kill existing tweens
	if text_tween:
		text_tween.kill()
	if transform_tween:
		transform_tween.kill()
	if wave_fade_tween:
		wave_fade_tween.kill()
	if shake_fade_tween:
		shake_fade_tween.kill()
	if glitch_fade_tween:
		glitch_fade_tween.kill()

	# Reverse transform animations if configured
	if _has_transform_animations():
		_reverse_transforms()

	if config.animate_typewriter:
		# Reverse typewriter: hide characters one by one
		var current_chars = text_label.visible_characters
		if current_chars < 0:
			current_chars = _target_visible_chars
		text_tween = text_label.create_tween()
		var type_duration = current_chars / config.characters_per_second
		text_tween.tween_property(text_label, VISIBLE_CHARACTERS, 0, type_duration)
		await text_tween.finished

	elif config.animate_text_apparate and text_shader_material:
		# Reverse apparate: fade back out
		var current_progress = text_shader_material.get_shader_parameter(APPARATE_PROGRESS)
		if current_progress == null:
			current_progress = 1.0 + config.apparate_spread
		var apparate_duration = current_progress / config.apparate_speed
		text_tween = text_label.create_tween()
		text_tween.tween_property(text_shader_material, SHADER_PARAMATER + APPARATE_PROGRESS, 0.0, apparate_duration)
		await text_tween.finished

	elif config.animate_text_crawl:
		# For crawl, just stop the animation
		pass

	elif _has_transform_animations() and transform_tween:
		# Wait for transform reverse to complete
		await transform_tween.finished

	# Disable continuous effects
	if text_shader_material:
		text_shader_material.set_shader_parameter(WAVE_ENABLED, 0.0)
		text_shader_material.set_shader_parameter(SHAKE_ENABLED, 0.0)
		text_shader_material.set_shader_parameter(GLITCH_ENABLED, 0.0)
		text_shader_material.set_shader_parameter(RAINBOW_ENABLED, 0.0)
		text_shader_material.set_shader_parameter(PULSE_ENABLED, 0.0)

	finished.emit()


## Kills all active tweens and emits finished to unblock any awaiting code.[br][br]
func kill() -> void:
	if text_tween:
		text_tween.kill()
		text_tween = null
	if transform_tween:
		transform_tween.kill()
		transform_tween = null
	if wave_fade_tween:
		wave_fade_tween.kill()
		wave_fade_tween = null
	if shake_fade_tween:
		shake_fade_tween.kill()
		shake_fade_tween = null
	if glitch_fade_tween:
		glitch_fade_tween.kill()
		glitch_fade_tween = null
	# Get shader material from label if we don't have a reference
	if not text_shader_material and text_label and text_label.material is ShaderMaterial:
		text_shader_material = text_label.material
	if text_shader_material:
		text_shader_material.set_shader_parameter(WAVE_ENABLED, 0.0)
		text_shader_material.set_shader_parameter(SHAKE_ENABLED, 0.0)
		text_shader_material.set_shader_parameter(GLITCH_ENABLED, 0.0)
		text_shader_material.set_shader_parameter(RAINBOW_ENABLED, 0.0)
		text_shader_material.set_shader_parameter(PULSE_ENABLED, 0.0)
	# Reset transform states
	if text_label:
		text_label.scale = Vector2.ONE
		text_label.rotation = 0.0
		text_label.position = Vector2.ZERO
	finished.emit()


## Skips the current text animation, completing it instantly.[br]
## Called when skip_on_click is enabled and user clicks.[br][br]
func skip() -> void:
	if text_tween and text_tween.is_running():
		text_tween.kill()
	if text_label and _target_visible_chars > 0:
		text_label.visible_characters = _target_visible_chars
		text_label.modulate.a = 1.0

		# Complete apparate animation if active (use 2.0 to ensure fade band is fully past)
		if text_shader_material and config.animate_text_apparate:
			text_shader_material.set_shader_parameter(APPARATE_PROGRESS, 2.0)


## Sets up the crawl effect (Star Wars style scrolling text).[br]
## Creates a clipping viewport and reparents the label into it.[br][br]
func _setup_crawl_effect() -> void:
	if not text_label:
		push_error("SSDM-UI: crawl effect - missing text_label")
		return

	# Show all characters immediately
	text_label.visible_characters = _target_visible_chars

	# Get content height (full text height)
	var content_height = text_label.get_content_height()
	if content_height <= 0:
		content_height = text_label.size.y
	if content_height <= 0:
		content_height = 100.0
		push_warning("SSDM-UI: crawl effect - using fallback content height")

	var viewport_height = config.crawl_height
	var original_parent = text_label.get_parent()

	# Create a clipping viewport container
	_crawl_viewport = Control.new()
	_crawl_viewport.name = CRAWL_VIEWPORT
	_crawl_viewport.clip_contents = true
	_crawl_viewport.custom_minimum_size.y = viewport_height
	_crawl_viewport.custom_minimum_size.x = 0
	_crawl_viewport.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	# 0 = shrink to beginning (default when SIZE_SHRINK_CENTER and SIZE_SHRINK_END not set)
	_crawl_viewport.size_flags_vertical = 0
	# Force size to not exceed minimum (prevent expansion)
	_crawl_viewport.set_deferred(SSDMGlobal.SIZE, Vector2(0, viewport_height))

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
	text_label.position.y = viewport_height

	# Calculate scroll distance: from bottom of viewport to all text exited top
	var scroll_distance = viewport_height + content_height

	# Calculate duration based on speed (pixels per second)
	var duration = scroll_distance / config.crawl_speed
	duration = max(duration, 1.0)

	# Set up shader for fade effect at top of viewport
	var fade_pixels = viewport_height * config.crawl_fade_height
	if text_shader_material and fade_pixels > 0.0:
		text_shader_material.set_shader_parameter(CRAWL_ENABLED, 1.0)
		text_shader_material.set_shader_parameter(CRAWL_FADE_PIXELS, fade_pixels)
		text_shader_material.set_shader_parameter(CRAWL_LABEL_POSITION_Y, viewport_height)

	# Animate label position scrolling up
	text_tween = text_label.create_tween()
	text_tween.set_parallel(true)

	# Tween the label's position
	text_tween.tween_property(
		text_label,
		POSITION_Y,
		-content_height,
		duration
	)

	# Tween the shader parameter in sync (for fade effect)
	if text_shader_material and fade_pixels > 0.0:
		text_tween.tween_property(
			text_shader_material,
			SHADER_PARAMATER + CRAWL_LABEL_POSITION_Y,
			-content_height,
			duration
		)

	await text_tween.finished


## Sets up continuous shader effects (wave, shake, glitch, rainbow, pulse).[br]
## These effects run continuously using TIME and don't need tweening.[br][br]
##
## @param duration - Duration before effects fade out (0 = infinite)[br]
func _setup_continuous_effects(duration: float) -> void:
	if not text_shader_material:
		return

	# Kill any existing fade tweens
	if wave_fade_tween:
		wave_fade_tween.kill()
	if shake_fade_tween:
		shake_fade_tween.kill()
	if glitch_fade_tween:
		glitch_fade_tween.kill()

	# Wave effect
	if config.animate_text_wave:
		text_shader_material.set_shader_parameter(WAVE_ENABLED, 1.0)
		text_shader_material.set_shader_parameter(WAVE_HORIZONTAL, 1.0 if config.wave_horizontal else 0.0)
		text_shader_material.set_shader_parameter(WAVE_AMPLITUDE, config.wave_amplitude)
		text_shader_material.set_shader_parameter(WAVE_FREQUENCY, config.wave_frequency)
		text_shader_material.set_shader_parameter(WAVE_SPEED, config.wave_speed)

		# Fade out wave after duration (if > 0)
		if duration > 0.0 and text_label:
			wave_fade_tween = text_label.create_tween()
			wave_fade_tween.tween_property(
				text_shader_material,
				SHADER_PARAMATER + WAVE_AMPLITUDE,
				0.0,
				duration
			)
	else:
		text_shader_material.set_shader_parameter(WAVE_ENABLED, 0.0)

	# Shake effect
	if config.animate_text_shake:
		text_shader_material.set_shader_parameter(SHAKE_ENABLED, 1.0)
		text_shader_material.set_shader_parameter(SHAKE_AMOUNT, config.text_shake_amount)
		text_shader_material.set_shader_parameter(SHAKE_SPEED, config.text_shake_speed)

		# Fade out shake after duration (if > 0)
		if duration > 0.0 and text_label:
			shake_fade_tween = text_label.create_tween()
			shake_fade_tween.tween_property(
				text_shader_material,
				SHADER_PARAMATER + SHAKE_AMOUNT,
				0.0,
				duration
			)
	else:
		text_shader_material.set_shader_parameter(SHAKE_ENABLED, 0.0)

	# Glitch effect
	if config.animate_text_glitch:
		text_shader_material.set_shader_parameter(GLITCH_ENABLED, 1.0)
		text_shader_material.set_shader_parameter(GLITCH_INTENSITY, config.glitch_intensity)
		text_shader_material.set_shader_parameter(GLITCH_SPEED, config.glitch_speed)
		text_shader_material.set_shader_parameter(GLITCH_BLOCK_SIZE, config.glitch_block_size)
		text_shader_material.set_shader_parameter(GLITCH_COLOR_DRIFT, config.glitch_color_drift)

		# Fade out glitch after duration (if > 0)
		if duration > 0.0 and text_label:
			glitch_fade_tween = text_label.create_tween()
			glitch_fade_tween.tween_property(
				text_shader_material,
				SHADER_PARAMATER + GLITCH_INTENSITY,
				0.0,
				duration
			)
	else:
		text_shader_material.set_shader_parameter(GLITCH_ENABLED, 0.0)

	# Rainbow effect
	if config.animate_text_rainbow:
		text_shader_material.set_shader_parameter(RAINBOW_ENABLED, 1.0)
		text_shader_material.set_shader_parameter(RAINBOW_FREQUENCY, config.rainbow_frequency)
		text_shader_material.set_shader_parameter(RAINBOW_SPEED, config.rainbow_speed)
		text_shader_material.set_shader_parameter(RAINBOW_SATURATION, config.rainbow_saturation)
	else:
		text_shader_material.set_shader_parameter(RAINBOW_ENABLED, 0.0)

	# Pulse effect
	if config.animate_text_pulse:
		text_shader_material.set_shader_parameter(PULSE_ENABLED, 1.0)
		text_shader_material.set_shader_parameter(PULSE_SPEED, config.pulse_speed)
		text_shader_material.set_shader_parameter(PULSE_MIN_ALPHA, config.pulse_min_alpha)
	else:
		text_shader_material.set_shader_parameter(PULSE_ENABLED, 0.0)


## Gets the character positions where each word ends (including trailing space).[br][br]
##
## @param text - The text to analyze[br]
## @return Array of character indices marking word boundaries[br]
func _get_word_end_positions(text: String) -> Array[int]:
	var positions: Array[int] = []
	var in_word = false

	for i in range(text.length()):
		var char = text[i]
		var is_whitespace = char == " " or char == "\t" or char == "\n"

		if in_word and is_whitespace:
			# End of word - include the whitespace
			positions.append(i + 1)
			in_word = false
		elif not is_whitespace:
			in_word = true

	# Add final position if text doesn't end with whitespace
	if in_word:
		positions.append(text.length())

	return positions


## Applies the text effects shader to the text label.[br]
## Creates and caches the ShaderMaterial for reuse.[br][br]
func _apply_text_shader() -> void:
	if not text_label:
		return

	# Store original material to restore later if needed
	if not _original_label_material and text_label.material:
		_original_label_material = text_label.material

	# Create shader material if not already created
	if not text_shader_material:
		# Build path relative to this script's location (works regardless of addon folder name)
		var script_path = get_script().resource_path.get_base_dir()
		var shader_path = script_path.path_join(TEXT_EFFECTS_SHADER_FILE)
		var shader = load(shader_path)
		if not shader:
			push_error("SSDM-UI: Failed to load shader from " + shader_path)
			return
		text_shader_material = ShaderMaterial.new()
		text_shader_material.shader = shader

	# Reset all effects to disabled (they'll be enabled as needed)
	text_shader_material.set_shader_parameter(WAVE_ENABLED, 0.0)
	text_shader_material.set_shader_parameter(SHAKE_ENABLED, 0.0)
	text_shader_material.set_shader_parameter(GLITCH_ENABLED, 0.0)
	text_shader_material.set_shader_parameter(RAINBOW_ENABLED, 0.0)
	text_shader_material.set_shader_parameter(APPARATE_ENABLED, 0.0)
	text_shader_material.set_shader_parameter(PULSE_ENABLED, 0.0)
	text_shader_material.set_shader_parameter(CRAWL_ENABLED, 0.0)

	text_label.material = text_shader_material


## Removes the text effects shader and restores the original material.[br][br]
func _remove_text_shader() -> void:
	if text_label:
		text_label.material = _original_label_material
	text_shader_material = null


## Returns reference to the crawl viewport if one was created.[br]
## Useful for callers who need to adjust layout after crawl animation.[br][br]
##
## @return The CrawlViewport Control or null if crawl was not used[br]
func get_crawl_viewport() -> Control:
	return _crawl_viewport


## Initializes the text animator with a RichTextLabel.[br][br]
##
## @param label - The RichTextLabel to animate[br]
func _init(label: RichTextLabel) -> void:
	text_label = label
