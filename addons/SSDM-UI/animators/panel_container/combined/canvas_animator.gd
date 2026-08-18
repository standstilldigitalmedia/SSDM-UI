@tool
## Animates any CanvasItem with transforms, tween visual effects, and shader effects.[br]
## Combines panel animator and icon animator capabilities into one unified animator.[br][br]
##
## Dependencies: SSDMCanvasAnimatorConfig only.[br]
## Created by passing target CanvasItem, optional wrapper, and optional rotation_container.
class_name SSDMCanvasAnimator
extends RefCounted

signal finished  ## Emitted when play() or reverse() completes.

const CANVAS_EFFECTS_SHADER_FILE: String = "../shader/canvas_effects.gdshader"

const X_PROPERTY: String = "custom_minimum_size:x"
const Y_PROPERTY: String = "custom_minimum_size:y"
const SCALE_PROPERTY: String = "scale"
const MODULATE_A_PROPERTY: String = "modulate:a"
const MODULATE_PROPERTY: String = "modulate"
const ROTATION_PROPERTY: String = "rotation"
const POSITION_PROPERTY: String = "position"
const POSITION_X_PROPERTY: String = "position:x"

const SHADER_PARAMETER: String = "shader_parameter/"
const HUE_SHIFT_ENABLED: String = "hue_shift_enabled"
const HUE_SHIFT_SPEED: String = "hue_shift_speed"
const GLOW_ENABLED: String = "glow_enabled"
const GLOW_INTENSITY: String = "glow_intensity"
const GLOW_COLOR: String = "glow_color"
const SHIMMER_ENABLED: String = "shimmer_enabled"
const SHIMMER_SPEED: String = "shimmer_speed"
const SHIMMER_WIDTH: String = "shimmer_width"
const SHIMMER_BRIGHTNESS: String = "shimmer_brightness"
const OUTLINE_ENABLED: String = "outline_enabled"
const OUTLINE_COLOR: String = "outline_color"
const OUTLINE_SIZE: String = "outline_size"
const DISSOLVE_ENABLED: String = "dissolve_enabled"
const DISSOLVE_MODE: String = "dissolve_mode"
const DISSOLVE_PROGRESS: String = "dissolve_progress"
const DISSOLVE_SPREAD: String = "dissolve_spread"
const PULSE_ENABLED: String = "pulse_enabled"
const PULSE_SPEED: String = "pulse_speed"
const PULSE_MIN_ALPHA: String = "pulse_min_alpha"
const FLICKER_ENABLED: String = "flicker_enabled"
const FLICKER_SPEED: String = "flicker_speed"
const FLICKER_MIN: String = "flicker_min"

var target: CanvasItem  ## The element being animated
var wrapper: Control  ## Optional wrapper for slide_out and clipping
var rotation_container: Control  ## Optional rotation isolation layer
var config: SSDMCanvasAnimatorConfig

var main_tween: Tween
var shader_material: ShaderMaterial
var _original_material: Material
var is_open: bool = false
var _monitoring: bool = false
var _delay_before: float = 0.0  ## Delay before playing (builder pattern)


## Configures the animator with animation parameters.[br][br]
func configure(cfg: SSDMCanvasAnimatorConfig) -> SSDMCanvasAnimator:
	config = cfg
	return self


# =============================================================================
# BUILDER PATTERN METHODS
# =============================================================================
# These methods allow fluent animation building without config files:
#   SSDMCanvasAnimator.new(panel).color(Color.RED, Color.WHITE).duration(0.3).play()

## Ensures a config exists, creating one if needed.[br][br]
func _ensure_config() -> void:
	if not config:
		config = SSDMCanvasAnimatorConfig.new()


# --- Slide Out ---

## Enables slide out animation (reveal/hide effect).[br][br]
func slide_out(axis: SSDMGlobal.Axis = SSDMGlobal.Axis.VERTICAL, direction: SSDMGlobal.OpenDirection = SSDMGlobal.OpenDirection.POSITIVE) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_slide_out = true
	config.axis = axis
	config.open_direction = direction
	return self


# --- Transform Animations ---

## Enables scale animation.[br][br]
func scale(from: Vector2 = Vector2(0.1, 0.1), to: Vector2 = Vector2.ONE, pivot: SSDMGlobal.RotationPivot = SSDMGlobal.RotationPivot.CENTER) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_scale = true
	config.scale_from = from
	config.scale_to = to
	config.scale_pivot_preset = pivot
	return self


## Enables rotation animation.[br][br]
func rotation(from_degrees: float = 0.0, to_degrees: float = 360.0, pivot: SSDMGlobal.RotationPivot = SSDMGlobal.RotationPivot.CENTER) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_rotation = true
	config.rotation_from_degrees = from_degrees
	config.rotation_to_degrees = to_degrees
	config.rotation_pivot_preset = pivot
	return self


## Enables position animation (slide from offset to zero).[br][br]
func position(offset: Vector2 = Vector2(20.0, 20.0)) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_position = true
	config.position_offset = offset
	return self


# --- Tween Visual Effects ---

## Enables fade animation.[br][br]
func fade(from: float = 0.0, to: float = 1.0) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_fade = true
	config.fade_from = from
	config.fade_to = to
	return self


## Enables color animation (background color tween).[br][br]
func color(from: Color, to: Color) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_color = true
	config.color_from = from
	config.color_to = to
	return self


## Enables shake animation.[br][br]
func shake(amount: float = 3.0, speed: float = 0.05) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_shake = true
	config.shake_amount = amount
	config.shake_speed = speed
	return self


# --- Shader Effects ---

## Enables glow effect.[br][br]
func glow(glow_color: Color = Color.WHITE, intensity: float = 1.0) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_glow = true
	config.glow_color = glow_color
	config.glow_intensity = intensity
	return self


## Enables pulse effect (oscillating alpha).[br][br]
func pulse(speed: float = 2.0, min_alpha: float = 0.2) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_pulse = true
	config.pulse_speed = speed
	config.pulse_min_alpha = min_alpha
	return self


## Enables hue shift effect (rainbow cycling).[br][br]
func hue_shift(speed: float = 1.0) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_hue_shift = true
	config.hue_shift_speed = speed
	return self


## Enables shimmer effect (diagonal highlight sweep).[br][br]
func shimmer(speed: float = 2.0, width: float = 0.2, brightness: float = 0.5) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_shimmer = true
	config.shimmer_speed = speed
	config.shimmer_width = width
	config.shimmer_brightness = brightness
	return self


## Enables outline effect.[br][br]
func outline(outline_color: Color = Color.WHITE, size: float = 1.0) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_outline = true
	config.outline_color = outline_color
	config.outline_size = size
	return self


## Enables dissolve effect.[br][br]
func dissolve(mode: SSDMCanvasAnimatorConfig.DissolveMode = SSDMCanvasAnimatorConfig.DissolveMode.UV_SWEEP, speed: float = 1.0, spread: float = 0.1) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_dissolve = true
	config.dissolve_mode = mode
	config.dissolve_speed = speed
	config.dissolve_spread = spread
	return self


## Enables flicker effect (random alpha).[br][br]
func flicker(speed: float = 10.0, min_alpha: float = 0.3) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animate_flicker = true
	config.flicker_speed = speed
	config.flicker_min = min_alpha
	return self


# --- Timing and Easing ---

## Sets a delay before the animation starts.[br][br]
func delay(seconds: float) -> SSDMCanvasAnimator:
	_delay_before = seconds
	return self


## Sets the animation duration in seconds.[br][br]
func duration(seconds: float) -> SSDMCanvasAnimator:
	_ensure_config()
	config.animation_speed = seconds
	return self


## Sets the easing type for both open and close.[br][br]
func ease(type: Tween.EaseType) -> SSDMCanvasAnimator:
	_ensure_config()
	config.ease_type_open = type
	config.ease_type_close = type
	return self


## Sets separate easing types for open and close.[br][br]
func ease_open_close(open_ease: Tween.EaseType, close_ease: Tween.EaseType) -> SSDMCanvasAnimator:
	_ensure_config()
	config.ease_type_open = open_ease
	config.ease_type_close = close_ease
	return self


## Sets the transition type (curve shape).[br][br]
func transition(type: Tween.TransitionType) -> SSDMCanvasAnimator:
	_ensure_config()
	config.transition_type = type
	return self


## Sets the clip mode for the wrapper.[br][br]
func clip(mode: SSDMGlobal.ClipMode) -> SSDMCanvasAnimator:
	_ensure_config()
	config.clip_mode = mode
	return self


## Sets the panel width for horizontal slide animations.[br][br]
func width(pixels: float) -> SSDMCanvasAnimator:
	_ensure_config()
	config.panel_width = pixels
	return self


# =============================================================================
# END BUILDER PATTERN METHODS
# =============================================================================


## Returns true if any tween-based animations are configured.[br][br]
func _has_tween_animations() -> bool:
	return (config.animate_slide_out or
			config.animate_scale or
			config.animate_rotation or
			config.animate_position or
			config.animate_fade or
			config.animate_color or
			config.animate_dissolve)


## Returns true if any continuous shader effects are configured.[br][br]
func _has_shader_effects() -> bool:
	return (config.animate_glow or
			config.animate_pulse or
			config.animate_hue_shift or
			config.animate_shimmer or
			config.animate_outline or
			config.animate_flicker)


## Calculates the pivot offset based on preset.[br][br]
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


## Gets the Control to use for transforms (rotation_container if available, else target).[br][br]
func _get_transform_target() -> Control:
	if rotation_container:
		return rotation_container
	if target is Control:
		return target as Control
	return null


## Gets the Control to use for wrapper operations (wrapper if available, else target).[br][br]
func _get_wrapper() -> Control:
	if wrapper:
		return wrapper
	if target is Control:
		return target as Control
	return null


## Gets the Control to use as panel (target if Control).[br][br]
func _get_panel() -> Control:
	if target is Control:
		return target as Control
	return null


## Plays the configured animations.[br][br]
##
## @param duration - For shader-only effects: 0 = run until interrupted, >0 = run for that duration.[br]
##                   For transforms: duration controls looping at the chain level, not here.[br]
func play(duration: float = 0.0) -> void:
	if not target or not config:
		push_error("SSDM-UI: target or config is null")
		finished.emit()
		return

	# Handle delay from builder pattern
	if _delay_before > 0.0:
		await target.get_tree().create_timer(_delay_before).timeout
		_delay_before = 0.0  # Reset for potential reuse

	if main_tween:
		main_tween.kill()

	# Handle shake separately (it's self-contained)
	if config.animate_shake:
		await _shake()
		finished.emit()
		return

	var has_tween = _has_tween_animations()
	var has_shader = _has_shader_effects()

	# Apply shader effects if needed
	if has_shader or config.animate_dissolve:
		_apply_shader()
		_setup_shader_effects()

	# If no tween animations, shader effects run for duration (or indefinitely if 0)
	if not has_tween and not config.animate_dissolve:
		if duration > 0.0:
			await target.get_tree().create_timer(duration).timeout
			_disable_shader_effects()
		finished.emit()
		return

	var wrap := _get_wrapper()
	var panel := _get_panel()
	var transform_target := _get_transform_target()

	var property_name: String
	var target_size: float
	var anim_speed: float = config.animation_speed

	# Setup slide_out
	if config.animate_slide_out and wrap and panel:
		if config.axis == SSDMGlobal.Axis.VERTICAL:
			property_name = Y_PROPERTY
			target_size = panel.get_combined_minimum_size().y
			if config.open_direction == SSDMGlobal.OpenDirection.POSITIVE:
				wrap.size_flags_vertical = 0
				panel.grow_vertical = Control.GROW_DIRECTION_BEGIN
				if rotation_container:
					rotation_container.grow_vertical = Control.GROW_DIRECTION_BEGIN
			else:
				wrap.size_flags_vertical = Control.SIZE_SHRINK_END
				panel.grow_vertical = Control.GROW_DIRECTION_END
				if rotation_container:
					rotation_container.grow_vertical = Control.GROW_DIRECTION_END
			wrap.custom_minimum_size.y = 0
		else:
			property_name = X_PROPERTY
			target_size = config.panel_width
			wrap.custom_minimum_size.x = config.panel_width
			wrap.size_flags_vertical = Control.SIZE_EXPAND_FILL
			panel.grow_vertical = Control.GROW_DIRECTION_BEGIN
			if rotation_container:
				rotation_container.grow_vertical = Control.GROW_DIRECTION_BEGIN
			if config.open_direction == SSDMGlobal.OpenDirection.POSITIVE:
				wrap.size_flags_horizontal = 0
				panel.grow_horizontal = Control.GROW_DIRECTION_BEGIN
				if rotation_container:
					rotation_container.grow_horizontal = Control.GROW_DIRECTION_BEGIN
			else:
				wrap.size_flags_horizontal = Control.SIZE_SHRINK_END
				panel.grow_horizontal = Control.GROW_DIRECTION_END
				if rotation_container:
					rotation_container.grow_horizontal = Control.GROW_DIRECTION_END

	# Setup initial states for transforms
	if config.animate_scale and panel:
		panel.scale = config.scale_from
	if config.animate_rotation and transform_target:
		transform_target.rotation = deg_to_rad(config.rotation_from_degrees)
	if config.animate_position and transform_target:
		transform_target.position = config.position_offset
	if config.animate_fade and wrap:
		wrap.modulate.a = config.fade_from
	if config.animate_color and panel:
		var stylebox = panel.get_theme_stylebox(SSDMGlobal.PANEL_THEME)
		if stylebox:
			stylebox.bg_color = config.color_from

	# Set clipping
	if wrap:
		match config.clip_mode:
			SSDMGlobal.ClipMode.AUTO:
				wrap.clip_contents = (config.animate_slide_out or config.animate_position) and not config.animate_rotation
			SSDMGlobal.ClipMode.ALWAYS:
				wrap.clip_contents = true
			SSDMGlobal.ClipMode.NEVER:
				wrap.clip_contents = false
		wrap.show()

	await target.get_tree().process_frame
	if not is_instance_valid(target):
		finished.emit()
		return

	# Set pivots after frame (now that sizes are known)
	if config.animate_scale and panel:
		panel.pivot_offset = _get_pivot_offset(panel, config.scale_pivot_preset)
	if config.animate_rotation and transform_target:
		transform_target.pivot_offset = _get_pivot_offset(transform_target, config.rotation_pivot_preset)

	# Recalculate sizes after frame
	if config.animate_slide_out and wrap and panel:
		if config.axis == SSDMGlobal.Axis.VERTICAL:
			target_size = panel.get_combined_minimum_size().y
		else:
			var panel_height = panel.get_combined_minimum_size().y
			wrap.custom_minimum_size.y = panel_height
			wrap.custom_minimum_size.x = 0

	# Create tween
	main_tween = target.create_tween()
	main_tween.set_parallel(true)
	main_tween.set_ease(config.ease_type_open)
	main_tween.set_trans(config.transition_type)

	# Animate slide_out
	if config.animate_slide_out and wrap:
		main_tween.tween_property(wrap, property_name, target_size, anim_speed).from(0)

	# Animate transforms
	if config.animate_scale and panel:
		main_tween.tween_property(panel, SCALE_PROPERTY, config.scale_to, anim_speed)
	if config.animate_rotation and transform_target:
		var to_radians = deg_to_rad(config.rotation_to_degrees)
		if config.rotation_to_degrees == 360.0 and config.rotation_from_degrees == 0.0:
			to_radians = TAU
		main_tween.tween_property(transform_target, ROTATION_PROPERTY, to_radians, anim_speed)
	if config.animate_position and transform_target:
		main_tween.tween_property(transform_target, POSITION_PROPERTY, Vector2.ZERO, anim_speed)

	# Animate tween visuals
	if config.animate_fade and wrap:
		main_tween.tween_property(wrap, MODULATE_A_PROPERTY, config.fade_to, anim_speed)
	if config.animate_color and panel:
		var stylebox = panel.get_theme_stylebox(SSDMGlobal.PANEL_THEME)
		if stylebox:
			main_tween.tween_property(stylebox, SSDMGlobal.BG_COLOR, config.color_to, anim_speed)

	# Animate dissolve (shader-based but tween-driven)
	if config.animate_dissolve and shader_material:
		shader_material.set_shader_parameter(DISSOLVE_ENABLED, 1.0)
		shader_material.set_shader_parameter(DISSOLVE_MODE, float(config.dissolve_mode))
		shader_material.set_shader_parameter(DISSOLVE_SPREAD, config.dissolve_spread)
		shader_material.set_shader_parameter(DISSOLVE_PROGRESS, 0.0)
		main_tween.tween_property(shader_material, SHADER_PARAMETER + DISSOLVE_PROGRESS, 1.0, config.dissolve_speed)

	await main_tween.finished
	is_open = true
	start_monitoring()
	finished.emit()


## Reverses the animation.[br]
## Set hide_after to false for looping animations that should stay visible.[br][br]
func reverse(hide_after: bool = true) -> void:
	if not target or not config:
		finished.emit()
		return

	# Handle delay from builder pattern
	if _delay_before > 0.0:
		await target.get_tree().create_timer(_delay_before).timeout
		_delay_before = 0.0  # Reset for potential reuse

	if hide_after:
		stop_monitoring()
		is_open = false

	if main_tween:
		main_tween.kill()

	var wrap := _get_wrapper()
	var panel := _get_panel()
	var transform_target := _get_transform_target()

	if wrap and not wrap.visible:
		finished.emit()
		return

	var has_tween = _has_tween_animations()

	if not has_tween and not config.animate_dissolve:
		_disable_shader_effects()
		if hide_after and wrap:
			wrap.hide()
		finished.emit()
		return

	var property_name: String
	var current_size: float
	var anim_speed: float = config.animation_speed

	# Setup slide_out reverse
	if config.animate_slide_out and wrap and panel:
		if config.axis == SSDMGlobal.Axis.VERTICAL:
			property_name = Y_PROPERTY
			current_size = wrap.custom_minimum_size.y if wrap.custom_minimum_size.y > 0 else wrap.size.y
			wrap.size_flags_vertical = 0 if config.open_direction == SSDMGlobal.OpenDirection.POSITIVE else Control.SIZE_SHRINK_END
		else:
			property_name = X_PROPERTY
			current_size = wrap.custom_minimum_size.x if wrap.custom_minimum_size.x > 0 else wrap.size.x
			wrap.size_flags_vertical = Control.SIZE_EXPAND_FILL
			wrap.size_flags_horizontal = 0 if config.open_direction == SSDMGlobal.OpenDirection.POSITIVE else Control.SIZE_SHRINK_END

	# Create tween
	main_tween = target.create_tween()
	main_tween.set_parallel(true)
	main_tween.set_ease(config.ease_type_close)
	main_tween.set_trans(config.transition_type)

	# Reverse slide_out
	if config.animate_slide_out and wrap:
		main_tween.tween_property(wrap, property_name, 0, anim_speed).from(current_size)

	# Reverse transforms
	if config.animate_scale and panel:
		main_tween.tween_property(panel, SCALE_PROPERTY, config.scale_from, anim_speed)
	if config.animate_rotation and transform_target:
		var from_radians = deg_to_rad(config.rotation_from_degrees)
		main_tween.tween_property(transform_target, ROTATION_PROPERTY, from_radians, anim_speed)
	if config.animate_position and transform_target:
		main_tween.tween_property(transform_target, POSITION_PROPERTY, config.position_offset, anim_speed)

	# Reverse tween visuals
	if config.animate_fade and wrap:
		main_tween.tween_property(wrap, MODULATE_A_PROPERTY, config.fade_from, anim_speed)
	if config.animate_color and panel:
		var stylebox = panel.get_theme_stylebox(SSDMGlobal.PANEL_THEME)
		if stylebox:
			main_tween.tween_property(stylebox, SSDMGlobal.BG_COLOR, config.color_from, anim_speed)

	# Reverse dissolve
	if config.animate_dissolve and shader_material:
		var current_progress = shader_material.get_shader_parameter(DISSOLVE_PROGRESS)
		if current_progress == null:
			current_progress = 1.0
		main_tween.tween_property(shader_material, SHADER_PARAMETER + DISSOLVE_PROGRESS, 0.0, config.dissolve_speed * float(current_progress))

	await main_tween.finished

	if hide_after:
		_disable_shader_effects()
		if wrap:
			wrap.hide()
			if config.animate_slide_out:
				if config.axis == SSDMGlobal.Axis.VERTICAL:
					wrap.custom_minimum_size.y = 0
				else:
					wrap.custom_minimum_size.x = 0
			wrap.clip_contents = false

		# Reset states
		if config.animate_scale and panel:
			panel.scale = Vector2.ONE
		if config.animate_rotation and transform_target:
			transform_target.rotation = 0.0
		if config.animate_position and transform_target:
			transform_target.position = Vector2.ZERO
		if config.animate_fade and wrap:
			wrap.modulate.a = 1.0

	finished.emit()


## Kills all active tweens and emits finished.[br][br]
func kill() -> void:
	stop_monitoring()
	if main_tween:
		main_tween.kill()
		main_tween = null
	_disable_shader_effects()
	# Reset transform states
	var panel := _get_panel()
	var transform_target := _get_transform_target()
	if panel:
		panel.scale = Vector2.ONE
	if transform_target:
		transform_target.rotation = 0.0
		transform_target.position = Vector2.ZERO
	finished.emit()


## Immediately hides without animation.[br][br]
func close_immediate() -> void:
	stop_monitoring()
	is_open = false
	if main_tween:
		main_tween.kill()
	_disable_shader_effects()

	var wrap := _get_wrapper()
	var panel := _get_panel()
	var transform_target := _get_transform_target()

	if wrap:
		wrap.hide()
		if config and config.animate_slide_out:
			if config.axis == SSDMGlobal.Axis.VERTICAL:
				wrap.custom_minimum_size.y = 0
			else:
				wrap.custom_minimum_size.x = 0
		wrap.clip_contents = false

	if config:
		if config.animate_scale and panel:
			panel.scale = Vector2.ONE
		if config.animate_rotation and transform_target:
			transform_target.rotation = 0.0
		if config.animate_position and transform_target:
			transform_target.position = Vector2.ZERO
		if config.animate_fade and wrap:
			wrap.modulate.a = 1.0


## Shakes the target horizontally.[br][br]
func _shake() -> void:
	var wrap := _get_wrapper()
	if not wrap or not wrap.visible:
		return
	var shake_tween = wrap.create_tween()
	var amount: float = config.shake_amount
	var speed: float = config.shake_speed
	shake_tween.tween_property(wrap, POSITION_X_PROPERTY, amount, speed)
	shake_tween.tween_property(wrap, POSITION_X_PROPERTY, -amount, speed)
	shake_tween.tween_property(wrap, POSITION_X_PROPERTY, amount / 2.0, speed)
	shake_tween.tween_property(wrap, POSITION_X_PROPERTY, 0, speed)
	await shake_tween.finished


## Applies the shader material to the target.[br][br]
func _apply_shader() -> void:
	if not target:
		return

	if not _original_material and target.material:
		_original_material = target.material

	if not shader_material:
		var script_path = get_script().resource_path.get_base_dir()
		var shader_path = script_path.path_join(CANVAS_EFFECTS_SHADER_FILE)
		var shader = load(shader_path)
		if not shader:
			push_error("SSDM-UI: Failed to load canvas shader from " + shader_path)
			return
		shader_material = ShaderMaterial.new()
		shader_material.shader = shader

	# Reset all effects to disabled
	shader_material.set_shader_parameter(HUE_SHIFT_ENABLED, 0.0)
	shader_material.set_shader_parameter(GLOW_ENABLED, 0.0)
	shader_material.set_shader_parameter(SHIMMER_ENABLED, 0.0)
	shader_material.set_shader_parameter(OUTLINE_ENABLED, 0.0)
	shader_material.set_shader_parameter(DISSOLVE_ENABLED, 0.0)
	shader_material.set_shader_parameter(PULSE_ENABLED, 0.0)
	shader_material.set_shader_parameter(FLICKER_ENABLED, 0.0)

	target.material = shader_material


## Sets shader uniforms for continuous effects.[br][br]
func _setup_shader_effects() -> void:
	if not shader_material:
		return

	if config.animate_hue_shift:
		shader_material.set_shader_parameter(HUE_SHIFT_ENABLED, 1.0)
		shader_material.set_shader_parameter(HUE_SHIFT_SPEED, config.hue_shift_speed)

	if config.animate_glow:
		shader_material.set_shader_parameter(GLOW_ENABLED, 1.0)
		shader_material.set_shader_parameter(GLOW_INTENSITY, config.glow_intensity)
		shader_material.set_shader_parameter(GLOW_COLOR, config.glow_color)

	if config.animate_shimmer:
		shader_material.set_shader_parameter(SHIMMER_ENABLED, 1.0)
		shader_material.set_shader_parameter(SHIMMER_SPEED, config.shimmer_speed)
		shader_material.set_shader_parameter(SHIMMER_WIDTH, config.shimmer_width)
		shader_material.set_shader_parameter(SHIMMER_BRIGHTNESS, config.shimmer_brightness)

	if config.animate_outline:
		shader_material.set_shader_parameter(OUTLINE_ENABLED, 1.0)
		shader_material.set_shader_parameter(OUTLINE_COLOR, config.outline_color)
		shader_material.set_shader_parameter(OUTLINE_SIZE, config.outline_size)

	if config.animate_pulse:
		shader_material.set_shader_parameter(PULSE_ENABLED, 1.0)
		shader_material.set_shader_parameter(PULSE_SPEED, config.pulse_speed)
		shader_material.set_shader_parameter(PULSE_MIN_ALPHA, config.pulse_min_alpha)

	if config.animate_flicker:
		shader_material.set_shader_parameter(FLICKER_ENABLED, 1.0)
		shader_material.set_shader_parameter(FLICKER_SPEED, config.flicker_speed)
		shader_material.set_shader_parameter(FLICKER_MIN, config.flicker_min)


## Disables all shader effects.[br][br]
func _disable_shader_effects() -> void:
	if not shader_material:
		return
	shader_material.set_shader_parameter(HUE_SHIFT_ENABLED, 0.0)
	shader_material.set_shader_parameter(GLOW_ENABLED, 0.0)
	shader_material.set_shader_parameter(SHIMMER_ENABLED, 0.0)
	shader_material.set_shader_parameter(OUTLINE_ENABLED, 0.0)
	shader_material.set_shader_parameter(PULSE_ENABLED, 0.0)
	shader_material.set_shader_parameter(FLICKER_ENABLED, 0.0)


## Starts monitoring panel size changes.[br][br]
func start_monitoring() -> void:
	var panel := _get_panel()
	if _monitoring or not panel:
		return
	if not panel.minimum_size_changed.is_connected(_on_panel_size_changed):
		panel.minimum_size_changed.connect(_on_panel_size_changed)
		_monitoring = true


## Stops monitoring panel size changes.[br][br]
func stop_monitoring() -> void:
	var panel := _get_panel()
	if not _monitoring or not panel:
		return
	if panel.minimum_size_changed.is_connected(_on_panel_size_changed):
		panel.minimum_size_changed.disconnect(_on_panel_size_changed)
	_monitoring = false


## Called when panel minimum size changes.[br][br]
func _on_panel_size_changed() -> void:
	var wrap := _get_wrapper()
	var panel := _get_panel()
	if not is_open or not wrap or not wrap.visible or not panel or not config:
		return
	if config.axis == SSDMGlobal.Axis.VERTICAL:
		var new_height = panel.get_combined_minimum_size().y
		if abs(wrap.custom_minimum_size.y - new_height) > 1.0:
			wrap.custom_minimum_size.y = new_height
	else:
		var new_width = panel.get_combined_minimum_size().x
		if abs(wrap.custom_minimum_size.x - new_width) > 1.0:
			wrap.custom_minimum_size.x = new_width


## Initializes the canvas animator.[br]
## For simple animations (icons, etc.), just pass the target.[br]
## For slide_out animations, pass wrapper and optionally rotation_container.[br][br]
##
## @param canvas_target - The CanvasItem to animate[br]
## @param canvas_wrapper - Optional wrapper Control for slide_out and clipping[br]
## @param rot_container - Optional rotation isolation container[br]
func _init(canvas_target: CanvasItem, canvas_wrapper: Control = null, rot_container: Control = null) -> void:
	target = canvas_target
	wrapper = canvas_wrapper
	rotation_container = rot_container
