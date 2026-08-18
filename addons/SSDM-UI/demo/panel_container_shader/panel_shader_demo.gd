extends PanelContainer

@export_group("Dissolve")
@export var dissolve_speed: float = 1.0  ## How many seconds the full animation takes.
@export var dissolve_mode: SSDMDissolveAnimator.DissolveMode = SSDMDissolveAnimator.DissolveMode.NOISE  ## UV_SWEEP = left-to-right; NOISE = random threshold; RADIAL = from center outward.
@export var dissolve_spread: float = 0.1  ## Edge softness of the dissolve transition.
@export var dissolve_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.

@export_subgroup("Timing and Easing")
@export var dissolve_ease_type_open: Tween.EaseType = Tween.EASE_OUT  ## Easing for opening/forward animation.
@export var dissolve_transition_type: Tween.TransitionType = Tween.TRANS_CUBIC  ## Math curve for animation motion.

@export_group("Flicker")
@export var flicker_speed: float = 10.0  ## Flicker updates per second.
@export var flicker_min: float = 0.3  ## Minimum alpha during a dark flicker frame.
@export var flicker_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.

@export_group("Hue Shift")
@export var hue_shift_speed: float = 1.0  ## Hue rotation speed in full cycles per second.
@export var hue_shift_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.

@export_group("Pulse")
@export var pulse_speed: float = 2.0  ## Cycles per second for the pulse.
@export var pulse_min_alpha: float = 0.2  ## Minimum alpha at the bottom of each pulse cycle.
@export var pulse_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.

@export_group("Shimmer")
@export var shimmer_speed: float = 2.0  ## How fast the shimmer band moves.
@export var shimmer_width: float = 0.2  ## Fractional width of the shimmer band (0-1).
@export var shimmer_brightness: float = 0.5  ## Additional brightness inside the shimmer band.
@export var shimmer_background_color: Color = Color(1.0, 1.0, 1.0, 1.0)  ## Main background color for the panel. Color animations will tween this value if enabled.

@export_group("Animators")
@export var dissolve_animator: SSDMDissolveAnimator
@export var flicker_animator: SSDMFlickerAnimator
@export var hue_shift_animator: SSDMHueShiftAnimator
@export var pulse_animator: SSDMPulseAnimator
@export var shimmer_animator: SSDMShimmerAnimator

func set_dissolve_animator() -> void:
	dissolve_animator.dissolve_speed = dissolve_speed
	dissolve_animator.dissolve_mode = dissolve_mode
	dissolve_animator.dissolve_spread = dissolve_spread
	dissolve_animator.dissolve_background_color = dissolve_background_color
	dissolve_animator.dissolve_ease_type_open = dissolve_ease_type_open
	dissolve_animator.dissolve_transition_type = dissolve_transition_type
	dissolve_animator.set_shader_paramaters()
	

func set_flicker_animator() -> void:
	flicker_animator.flicker_speed = flicker_speed
	flicker_animator.flicker_min = flicker_min
	flicker_animator.flicker_background_color = flicker_background_color
	flicker_animator.set_shader_paramaters()
	
	
func set_hue_shift_animator() -> void:
	hue_shift_animator.hue_shift_speed = hue_shift_speed
	hue_shift_animator.hue_shift_background_color = hue_shift_background_color
	hue_shift_animator.set_shader_paramaters()
	
	
func set_pulse_animator() -> void:
	pulse_animator.pulse_speed = pulse_speed
	pulse_animator.pulse_min_alpha = pulse_min_alpha
	pulse_animator.pulse_background_color = pulse_background_color
	pulse_animator.set_shader_paramaters()
	
	
func set_shimmer_animator() -> void:
	shimmer_animator.shimmer_speed = shimmer_speed
	shimmer_animator.shimmer_width = shimmer_width
	shimmer_animator.shimmer_brightness = shimmer_brightness
	shimmer_animator.shimmer_background_color = shimmer_background_color
	shimmer_animator.set_shader_paramaters()
	

func _ready() -> void:
	set_dissolve_animator()
	set_flicker_animator()
	set_hue_shift_animator()
	set_pulse_animator()
	set_shimmer_animator()


func _on_dissolve_start_button_pressed() -> void:
	dissolve_animator.play()


func _on_dissolve_stop_button_pressed() -> void:
	dissolve_animator.kill()
	
	
func _on_dissolve_reverse_button_pressed() -> void:
	dissolve_animator.reverse()


func _on_flicker_start_button_pressed() -> void:
	flicker_animator.play()


func _on_flicker_stop_button_pressed() -> void:
	flicker_animator.kill()


func _on_hue_shift_start_button_pressed() -> void:
	hue_shift_animator.play()


func _on_hue_shift_stop_button_pressed() -> void:
	hue_shift_animator.kill()


func _on_pulse_start_button_pressed() -> void:
	pulse_animator.play()


func _on_pulse_stop_button_pressed() -> void:
	pulse_animator.kill()


func _on_shimmer_start_button_pressed() -> void:
	shimmer_animator.play()


func _on_shimmer_stop_button_pressed() -> void:
	shimmer_animator.kill()
