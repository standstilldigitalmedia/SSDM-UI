@tool
## A fully animated text input with shader effects on background.[br]
## Works with either LineEdit (single-line) or TextEdit (multi-line) as the input node.[br]
## All built-in input visuals are suppressed; animation chains drive the appearance.[br][br]
##
## Use animated_line_edit.tscn for single-line input, animated_text_edit.tscn for multi-line.
class_name SSDMAnimatedTextInput
extends Control

@export_group("Input Size")
@export var input_width: float = 0.0  ## 0 = fill parent, >0 = fixed width in pixels.
@export var input_height: float = 0.0  ## 0 = fill parent, >0 = fixed height in pixels.

@export_group("Text")
@export var text: String = "":
	set(value):
		text = value
		if input_node:
			input_node.text = value
	get:
		if input_node:
			return input_node.text
		return text
@export var placeholder_text: String = "":
	set(value):
		placeholder_text = value
		if input_node:
			input_node.placeholder_text = value
@export var font: Font
@export var font_color: Color = Color.WHITE
@export var font_size: int = 14
@export var editable: bool = true:
	set(value):
		editable = value
		if input_node:
			input_node.editable = value

@export_group("Background")
@export var background_color: Color = Color(1.0, 1.0, 1.0, 0.2)

@export_group("Border")
@export var border_color: Color = Color(1.0, 1.0, 1.0, 0.3)
@export var border_top: int = 0
@export var border_left: int = 0
@export var border_bottom: int = 0
@export var border_right: int = 0

@export_group("Corner Radius")
@export var top_left_corner_radius: int = 0
@export var top_right_corner_radius: int = 0
@export var bottom_left_corner_radius: int = 0
@export var bottom_right_corner_radius: int = 0

@export_group("Margins")
@export var margin_top: int = 6
@export var margin_left: int = 8
@export var margin_bottom: int = 6
@export var margin_right: int = 8

@export_group("Animation Chains")
@export var focus_in_chain: Array[SSDMInputStep] = []
@export var focus_out_chain: Array[SSDMInputStep] = []
@export var disabled_chain: Array[SSDMInputStep] = []

@export_group("Control")
@export var background_panel: PanelContainer
@export var margin_container: MarginContainer
@export var input_node: Control  ## LineEdit or TextEdit

# Chain interruption counter
var _chain_generation: int = 0

# Active animator reference
var _current_panel_anim: SSDMCanvasAnimator = null

var _was_disabled: bool = false


func _get_minimum_size() -> Vector2:
	if background_panel and is_instance_valid(background_panel):
		return background_panel.get_combined_minimum_size()
	return super.get_minimum_size()


## Applies all visual configuration to the input's child nodes.[br][br]
func configure() -> void:
	if not background_panel or not margin_container or not input_node:
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

	# Configure input node
	input_node.text = text
	input_node.placeholder_text = placeholder_text
	input_node.editable = editable

	# Apply font settings
	if font:
		input_node.add_theme_font_override("font", font)
	input_node.add_theme_color_override("font_color", font_color)
	input_node.add_theme_font_size_override("font_size", font_size)

	# Suppress built-in input visual states with empty styleboxes
	var empty = StyleBoxEmpty.new()
	input_node.add_theme_stylebox_override("normal", empty)
	input_node.add_theme_stylebox_override("focus", empty)
	input_node.add_theme_stylebox_override("read_only", empty)

	# Configure input size
	_configure_input_size()

	# Children should not intercept mouse events for sizing — input_node handles all input
	background_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin_container.mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Notify parent containers of our size
	update_minimum_size()


## Configures input size based on input_width and input_height.
## When 0, fills parent. When > 0, uses fixed size.
func _configure_input_size() -> void:
	# Configure horizontal sizing
	if input_width == 0.0:
		anchor_left = 0.0
		anchor_right = 1.0
		offset_left = 0.0
		offset_right = 0.0
		size_flags_horizontal = Control.SIZE_EXPAND_FILL
		custom_minimum_size.x = 0.0
	else:
		anchor_left = 0.0
		anchor_right = 0.0
		offset_right = input_width
		size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		custom_minimum_size.x = input_width

	# Configure vertical sizing independently
	if input_height == 0.0:
		anchor_top = 0.0
		anchor_bottom = 1.0
		offset_top = 0.0
		offset_bottom = 0.0
		size_flags_vertical = Control.SIZE_EXPAND_FILL
		custom_minimum_size.y = 0.0
	else:
		anchor_top = 0.0
		anchor_bottom = 0.0
		offset_bottom = input_height
		size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		custom_minimum_size.y = input_height


func _ready() -> void:
	configure()
	# Propagate BackgroundPanel minimum size changes up to our parent container
	if background_panel and not background_panel.minimum_size_changed.is_connected(update_minimum_size):
		background_panel.minimum_size_changed.connect(update_minimum_size)
	if Engine.is_editor_hint():
		return
	# Connect focus signals
	input_node.focus_entered.connect(_on_focus_in)
	input_node.focus_exited.connect(_on_focus_out)
	_was_disabled = not editable


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	# Check for disabled state change
	var is_disabled := not editable
	if is_disabled != _was_disabled:
		_was_disabled = is_disabled
		if is_disabled:
			_play_chain(disabled_chain)
		else:
			_play_chain([])


# --- Signal handlers ---

func _on_focus_in() -> void:
	_play_chain(focus_in_chain)


func _on_focus_out() -> void:
	if focus_out_chain.is_empty():
		_play_chain(focus_in_chain, true)
	else:
		_play_chain(focus_out_chain)


# --- Chain runner ---

## Kills all currently active animators.[br][br]
func _kill_active_animators() -> void:
	if _current_panel_anim:
		_current_panel_anim.kill()
		_current_panel_anim = null


## Plays an animation chain. Increments the generation counter to cancel any running chain.[br][br]
##
## @param chain - Array of SSDMInputStep resources to play in sequence[br]
## @param auto_reverse - If true, reverses the animation direction[br]
func _play_chain(chain: Array[SSDMInputStep], auto_reverse: bool = false) -> void:
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

		# Create animator for this step
		var panel_anim: SSDMCanvasAnimator = null

		if step.panel_animation:
			panel_anim = SSDMCanvasAnimator.new(background_panel, self, self)
			panel_anim.configure(step.panel_animation)
			_current_panel_anim = panel_anim

		# Determine effective direction
		var should_reverse: bool = auto_reverse != step.panel_reverse

		# Determine if animator loops (duration = 0 means loop)
		var panel_loops: bool = step.panel_animation and step.panel_duration == 0.0

		# Play animator
		if panel_anim:
			if should_reverse:
				panel_anim.reverse(false)
			else:
				panel_anim.play(step.panel_duration)

		if panel_loops:
			# Loop until chain is interrupted
			while _chain_generation == my_gen:
				if panel_anim:
					if should_reverse:
						panel_anim.reverse(false)
					else:
						panel_anim.play(step.panel_duration)
					await panel_anim.finished
					if _chain_generation != my_gen:
						return
			return
		else:
			# Await animator
			if panel_anim:
				await panel_anim.finished
				if _chain_generation != my_gen:
					return
