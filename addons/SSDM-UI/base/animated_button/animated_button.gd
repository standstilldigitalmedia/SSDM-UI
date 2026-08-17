@tool
## A fully animated button with shader effects on body, label, and icon.[br]
## Extends Button for full BaseButton API compatibility (disabled, toggle_mode, action_mode, signals).[br]
## All built-in Button visuals are suppressed; animation chains drive the appearance.[br][br]
##
## Wire chains via the exported arrays in the inspector, or assign them in code.
class_name SSDMAnimatedButton
extends Control

signal pressed()
signal toggled(toggled_on: bool)

@export_group("Button")
@export var button_width: float = 0.0
@export var button_height: float = 0.0
@export var toggle_mode: bool = false

@export_group("Icon")
@export var show_icon: bool = false
@export var open_icon: Texture2D = null  ## Default icon when toggle mode is turned off
@export var close_icon: Texture2D = null
@export var expand_icon: bool = true
@export var icon_modulate: Color = Color.WHITE
@export var icon_h_alignment: HorizontalAlignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_CENTER
@export var icon_v_alignment: VerticalAlignment = VerticalAlignment.VERTICAL_ALIGNMENT_CENTER

@export_group("Text")
@export var button_text: String = ""
@export var button_tooltip_text: String = ""
@export var vertical_button_text: bool = false ## If true, the text on the main panel button will be stacked vertically
@export var font: Font
@export var font_color: Color = Color.WHITE
@export var font_size: int = 14
@export var text_h_alignment: SSDMGlobal.Alignment = SSDMGlobal.Alignment.Center
@export var text_v_alignment: SSDMGlobal.Alignment = SSDMGlobal.Alignment.Center

@export_group("Background")
@export var background_color: Color = Color(1.0, 1.0, 1.0, 0.2)

@export_group("Border")
@export var border_color: Color = Color(1.0, 1.0, 1.0, 0.3)
@export var border_top: int = 0
@export var border_left: int = 0
@export var border_bottom: int = 0
@export var border_right: int = 0

@export_group("Corner Radius")
@export var top_left_corner_radius: int = 0  ## Roundness of the top-left corner in pixels. 0 = sharp corner, higher = more rounded.
@export var top_right_corner_radius: int = 0  ## Roundness of the top-right corner in pixels. 0 = sharp corner, higher = more rounded.
@export var bottom_left_corner_radius: int = 0  ## Roundness of the bottom-left corner in pixels. 0 = sharp corner, higher = more rounded.
@export var bottom_right_corner_radius: int = 0  ## Roundness of the bottom-right corner in pixels. 0 = sharp corner, higher = more rounded.

@export_group("Margins")
@export var margin_top: int = 6
@export var margin_left: int = 8
@export var margin_bottom: int = 6
@export var margin_right: int = 8

@export_group("Animation Chains")
@export var hover_in_chain: Array[SSDMButtonStep] = []
@export var hover_out_chain: Array[SSDMButtonStep] = []
@export var press_chain: Array[SSDMButtonStep] = []
@export var release_chain: Array[SSDMButtonStep] = []
@export var focus_in_chain: Array[SSDMButtonStep] = []
@export var focus_out_chain: Array[SSDMButtonStep] = []
@export var disabled_chain: Array[SSDMButtonStep] = []

@export_group("Control")
@export var button: Button
@export var background_panel: PanelContainer
@export var margin_container: MarginContainer
@export var content_container: Control
@export var icon_control: Control
@export var icon_texture_rect: TextureRect
@export var button_label: SSDMAnimatedText

# Chain interruption counter
var _chain_generation: int = 0

# Active animator references for kill()
var _current_panel_anim: SSDMCanvasAnimator = null
var _current_text_anim: SSDMTextAnimator = null
var _current_icon_anim: SSDMCanvasAnimator = null

var _was_disabled: bool = false


func _string_to_vertical(text: String) -> String:
	var chars := []
	for char in text:
		if char != " ":
			chars.append(char)
		else:
			chars.append("")  # Empty string creates gap without visible newline
	return "\n".join(chars)
	
	
func _get_minimum_size() -> Vector2:
	if background_panel and is_instance_valid(background_panel):
		return background_panel.get_combined_minimum_size()
	return super.get_minimum_size()


## Applies all visual configuration to the button's child nodes.[br][br]
func configure() -> void:
	if not background_panel or not margin_container or not content_container or not icon_control or not icon_texture_rect or not button_label:
		return

	# Build and apply background stylebox
	var style = StyleBoxFlat.new()
	style.bg_color = background_color
	style.border_color = border_color
	style.border_width_top = border_top
	style.border_width_left = border_left
	style.border_width_bottom = border_bottom
	style.border_width_right = border_right
	style.corner_radius_top_left = top_left_corner_radius
	style.corner_radius_top_right = top_right_corner_radius
	style.corner_radius_bottom_left = bottom_left_corner_radius
	style.corner_radius_bottom_right = bottom_right_corner_radius
	background_panel.add_theme_stylebox_override(SSDMGlobal.PANEL_THEME, style)

	# Apply margins
	margin_container.add_theme_constant_override(SSDMGlobal.MARGIN_TOP, margin_top)
	margin_container.add_theme_constant_override(SSDMGlobal.MARGIN_LEFT, margin_left)
	margin_container.add_theme_constant_override(SSDMGlobal.MARGIN_BOTTOM, margin_bottom)
	margin_container.add_theme_constant_override(SSDMGlobal.MARGIN_RIGHT, margin_right)

	# Configure icon
	if !show_icon or !open_icon:
		icon_control.hide()
	else:
		icon_control.show()
		icon_texture_rect.texture = open_icon
		icon_texture_rect.modulate = icon_modulate
		_configure_icon_size()

	# Configure label
	button_label.label_text_h_alignment = text_h_alignment
	button_label.label_text_v_alignment = text_v_alignment
	button_label.font = font
	button_label.font_color = font_color
	button_label.font_size = font_size
	if vertical_button_text:
		button_label.text = _string_to_vertical(button_text)
	else:
		button_label.text = button_text
	button_label.configure()
	
	button.tooltip_text = button_tooltip_text
	button.toggle_mode = toggle_mode
	button.icon_alignment = icon_h_alignment
	button.vertical_icon_alignment = icon_v_alignment
	button.expand_icon = expand_icon

	# Set content_container minimum size so panel minimum size calculation is correct
	# (ContentContainer is a plain Control with anchor-positioned children, which don't
	# contribute to minimum size - we must set it explicitly)
	_configure_content_minimum_size()

	# Configure button size
	_configure_button_size()

	# Suppress all built-in Button visual states
	var empty = StyleBoxEmpty.new()
	add_theme_stylebox_override("normal", empty)
	add_theme_stylebox_override("hover", empty)
	add_theme_stylebox_override("pressed", empty)
	add_theme_stylebox_override("focus", empty)
	add_theme_stylebox_override("disabled", empty)

	# Children should not intercept mouse events — Button root handles all input
	background_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	content_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon_control.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon_texture_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	button_label.mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Button extends Control, not Container, so minimum_size_changed from BackgroundPanel
	# does not automatically propagate to the parent container. Notify explicitly so that
	# containers like HBoxContainer re-query our size after configure() sets up content.
	update_minimum_size()


## Configures icon size based on icon_expand (like Button's expand_icon).
## When true, icon scales to fill available space. When false, keeps natural texture size.
func _configure_icon_size() -> void:
	if expand_icon:
		# Expand to fill the content container (like Button's expand_icon = true)
		icon_control.custom_minimum_size = Vector2.ZERO
		icon_texture_rect.custom_minimum_size = Vector2.ZERO
		icon_control.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		icon_texture_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		icon_texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon_texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	else:
		# Keep natural texture size (like Button's expand_icon = false)
		var tex_size := Vector2.ZERO
		if open_icon:
			tex_size = open_icon.get_size()
		icon_control.custom_minimum_size = tex_size
		icon_texture_rect.custom_minimum_size = tex_size
		icon_control.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
		icon_texture_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		icon_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		icon_texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
			


## Sets content_container minimum size based on font line height and icon.
## This ensures the panel's minimum size calculation includes actual content height,
## which is needed for panel animations that query background_panel.get_combined_minimum_size().
func _configure_content_minimum_size() -> void:
	if not content_container:
		return
	var content_width := 0.0
	var content_height := 0.0
	if button_label and is_instance_valid(button_label):
		var label_font := font if font else button_label.get_theme_default_font()
		if label_font:
			content_height = label_font.get_height(font_size)
	# Icon is shown when show_icon=false and icon_texture exists (inverted naming)
	if not show_icon and open_icon:
		var icon_min := icon_control.custom_minimum_size
		content_width = max(content_width, icon_min.x)
		content_height = max(content_height, icon_min.y)
	content_container.custom_minimum_size = Vector2(content_width, content_height)


## Configures button size based on button_width and button_height.
## When 0, fills parent. When > 0, uses fixed size.
func _configure_button_size() -> void:
	# Button always fills the root Control
	button.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	# Calculate minimum content size for when we need it
	var min_content_width := margin_left + margin_right
	var min_content_height := margin_top + margin_bottom

	if button_label and is_instance_valid(button_label):
		var label_font := font if font else button_label.get_theme_default_font()
		if label_font:
			min_content_height += label_font.get_height(font_size)

	# Icon is shown when show_icon=false and icon_texture exists (inverted naming)
	if not show_icon and open_icon:
		var icon_min := icon_control.custom_minimum_size
		min_content_width += icon_min.x
		min_content_height = max(min_content_height, margin_top + icon_min.y + margin_bottom)

	# Configure horizontal sizing
	if button_width == 0.0:
		# Fill parent horizontally
		anchor_left = 0.0
		anchor_right = 1.0
		offset_left = 0.0
		offset_right = 0.0
		size_flags_horizontal = Control.SIZE_EXPAND_FILL
		custom_minimum_size.x = 0.0
	else:
		# Fixed width - use left anchor only, set minimum size
		anchor_left = 0.0
		anchor_right = 0.0
		offset_right = button_width
		size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		custom_minimum_size.x = button_width

	# Configure vertical sizing independently
	if button_height == 0.0:
		# Fill parent vertically
		anchor_top = 0.0
		anchor_bottom = 1.0
		offset_top = 0.0
		offset_bottom = 0.0
		size_flags_vertical = Control.SIZE_EXPAND_FILL
		custom_minimum_size.y = 0.0
	else:
		# Fixed height - use top anchor only, set minimum size
		anchor_top = 0.0
		anchor_bottom = 0.0
		offset_bottom = button_height
		size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		custom_minimum_size.y = button_height


## Applies a PositionPreset to a Control's anchors and offsets.
func _apply_position_preset(ctrl: Control, preset: SSDMGlobal.PositionPreset) -> void:
	var size := ctrl.custom_minimum_size
	var anchor_x: float
	var anchor_y: float
	var offset_x: float
	var offset_y: float
	var grow_h: Control.GrowDirection
	var grow_v: Control.GrowDirection

	# Horizontal positioning
	match preset:
		SSDMGlobal.PositionPreset.TOP_LEFT, SSDMGlobal.PositionPreset.CENTER_LEFT, SSDMGlobal.PositionPreset.BOTTOM_LEFT:
			anchor_x = 0.0
			offset_x = 0.0
			grow_h = Control.GROW_DIRECTION_END
		SSDMGlobal.PositionPreset.TOP_CENTER, SSDMGlobal.PositionPreset.CENTER, SSDMGlobal.PositionPreset.BOTTOM_CENTER:
			anchor_x = 0.5
			offset_x = -size.x / 2.0
			grow_h = Control.GROW_DIRECTION_BOTH
		SSDMGlobal.PositionPreset.TOP_RIGHT, SSDMGlobal.PositionPreset.CENTER_RIGHT, SSDMGlobal.PositionPreset.BOTTOM_RIGHT:
			anchor_x = 1.0
			offset_x = -size.x
			grow_h = Control.GROW_DIRECTION_BEGIN

	# Vertical positioning
	match preset:
		SSDMGlobal.PositionPreset.TOP_LEFT, SSDMGlobal.PositionPreset.TOP_CENTER, SSDMGlobal.PositionPreset.TOP_RIGHT:
			anchor_y = 0.0
			offset_y = 0.0
			grow_v = Control.GROW_DIRECTION_END
		SSDMGlobal.PositionPreset.CENTER_LEFT, SSDMGlobal.PositionPreset.CENTER, SSDMGlobal.PositionPreset.CENTER_RIGHT:
			anchor_y = 0.5
			offset_y = -size.y / 2.0
			grow_v = Control.GROW_DIRECTION_BOTH
		SSDMGlobal.PositionPreset.BOTTOM_LEFT, SSDMGlobal.PositionPreset.BOTTOM_CENTER, SSDMGlobal.PositionPreset.BOTTOM_RIGHT:
			anchor_y = 1.0
			offset_y = -size.y
			grow_v = Control.GROW_DIRECTION_BEGIN

	ctrl.anchor_left = anchor_x
	ctrl.anchor_right = anchor_x
	ctrl.anchor_top = anchor_y
	ctrl.anchor_bottom = anchor_y
	ctrl.offset_left = offset_x
	ctrl.offset_right = offset_x + size.x
	ctrl.offset_top = offset_y
	ctrl.offset_bottom = offset_y + size.y
	ctrl.grow_horizontal = grow_h
	ctrl.grow_vertical = grow_v


func _ready() -> void:
	configure()
	# Propagate BackgroundPanel minimum size changes up to our parent container at runtime
	if background_panel and not background_panel.minimum_size_changed.is_connected(update_minimum_size):
		background_panel.minimum_size_changed.connect(update_minimum_size)
	if Engine.is_editor_hint():
		return
	# Connect mouse signals to button since it fills the control and receives all mouse events
	button.mouse_entered.connect(_on_hover_in)
	button.mouse_exited.connect(_on_hover_out)
	button.button_down.connect(_on_press)
	button.button_up.connect(_on_release)
	button.focus_entered.connect(_on_focus_in)
	button.focus_exited.connect(_on_focus_out)
	_was_disabled = button.disabled


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if button.disabled != _was_disabled:
		_was_disabled = button.disabled
		if button.disabled:
			_play_chain(disabled_chain)
		else:
			# Interrupt any running disabled chain cleanly
			_play_chain([])


# --- Signal handlers ---

func _on_hover_in() -> void:
	_play_chain(hover_in_chain)


func _on_hover_out() -> void:
	if hover_out_chain.is_empty():
		_play_chain(hover_in_chain, true)
	else:
		_play_chain(hover_out_chain)


func _on_press() -> void:
	_play_chain(press_chain)


func _on_release() -> void:
	if release_chain.is_empty():
		_play_chain(press_chain, true)
	else:
		_play_chain(release_chain)


func _on_focus_in() -> void:
	_play_chain(focus_in_chain)


func _on_focus_out() -> void:
	if focus_out_chain.is_empty():
		_play_chain(focus_in_chain, true)
	else:
		_play_chain(focus_out_chain)


# --- Chain runner ---

## Kills all currently active animators and emits their finished signals.[br][br]
func _kill_active_animators() -> void:
	if _current_panel_anim:
		_current_panel_anim.kill()
		_current_panel_anim = null
	if _current_text_anim:
		_current_text_anim.kill()
		_current_text_anim = null
	if _current_icon_anim:
		_current_icon_anim.kill()
		_current_icon_anim = null


## Plays an animation chain. Increments the generation counter to cancel any running chain.[br][br]
##
## @param chain - Array of SSDMButtonStep resources to play in sequence[br]
## @param auto_reverse_panel - If true, reverses the panel body animation direction (for auto-reverse on hover_out etc.)[br]
func _play_chain(chain: Array[SSDMButtonStep], auto_reverse_panel: bool = false) -> void:
	_chain_generation += 1
	var my_gen := _chain_generation
	_kill_active_animators()

	for step in chain:
		if _chain_generation != my_gen:
			return

		if step.delay_before > 0.0:
			await get_tree().create_timer(step.delay_before).timeout
			if _chain_generation != my_gen:
				return

		# Create animators for this step
		var panel_anim: SSDMCanvasAnimator = null
		var text_anim: SSDMTextAnimator = null
		var icon_anim: SSDMCanvasAnimator = null

		if step.panel_animation:
			panel_anim = SSDMCanvasAnimator.new(background_panel, self, self)
			panel_anim.configure(step.panel_animation)
			_current_panel_anim = panel_anim

		if step.text_animation:
			text_anim = SSDMTextAnimator.new(button_label)
			text_anim.configure(step.text_animation)
			_current_text_anim = text_anim

		if step.icon_animation:
			icon_anim = SSDMCanvasAnimator.new(icon_texture_rect)
			icon_anim.configure(step.icon_animation)
			_current_icon_anim = icon_anim

		# Determine effective directions: XOR auto_reverse with step flags
		var should_reverse_panel: bool = auto_reverse_panel != step.panel_reverse
		var should_reverse_icon: bool = auto_reverse_panel != step.icon_reverse

		# Determine which animators loop (duration = 0 means loop)
		var panel_loops: bool = step.panel_animation and step.panel_duration == 0.0
		var text_loops: bool = step.text_animation and step.text_duration == 0.0
		var icon_loops: bool = step.icon_animation and step.icon_duration == 0.0

		# Play all animators simultaneously
		if panel_anim:
			if should_reverse_panel:
				panel_anim.reverse(false)
			else:
				panel_anim.play(step.panel_duration)

		if text_anim:
			if auto_reverse_panel:
				text_anim.reverse()
			else:
				text_anim.play(step.text_duration)

		if icon_anim:
			if should_reverse_icon:
				icon_anim.reverse()
			else:
				icon_anim.play(step.icon_duration)

		# Check if any animator should loop this step
		var has_loop: bool = panel_loops or text_loops or icon_loops

		if has_loop:
			# Await non-looping animators once, then enter the loop
			if panel_anim and not panel_loops:
				await panel_anim.finished
				if _chain_generation != my_gen:
					return
			if text_anim and not text_loops:
				await text_anim.finished
				if _chain_generation != my_gen:
					return
			if icon_anim and not icon_loops:
				await icon_anim.finished
				if _chain_generation != my_gen:
					return

			# Loop all flagged animators until chain is interrupted
			while _chain_generation == my_gen:
				if panel_anim and panel_loops:
					if should_reverse_panel:
						panel_anim.reverse(false)
					else:
						panel_anim.play(step.panel_duration)
					await panel_anim.finished
					if _chain_generation != my_gen:
						return

				if text_anim and text_loops:
					if auto_reverse_panel:
						text_anim.reverse()
					else:
						text_anim.play(step.text_duration)
					await text_anim.finished
					if _chain_generation != my_gen:
						return

				if icon_anim and icon_loops:
					if should_reverse_icon:
						icon_anim.reverse()
					else:
						icon_anim.play(step.icon_duration)
					await icon_anim.finished
					if _chain_generation != my_gen:
						return

			return  # Looping step consumed the rest of the chain

		else:
			# Await all animators sequentially (they started in parallel above)
			if panel_anim:
				await panel_anim.finished
				if _chain_generation != my_gen:
					return
			if text_anim:
				await text_anim.finished
				if _chain_generation != my_gen:
					return
			if icon_anim:
				await icon_anim.finished
				if _chain_generation != my_gen:
					return


func _on_button_pressed() -> void:
	pressed.emit()


func _on_button_toggled(toggled_on: bool) -> void:
	if toggle_mode:
		if toggled_on:
			button.icon = close_icon
		else:
			button.icon = open_icon
	toggled.emit(toggled_on)
