## Configuration resource for SSDMCanvasAnimator.[br]
## Combines transform animations, tween-based visual effects, and shader effects.[br]
## Works on any CanvasItem: PanelContainer, TextureRect, Control, etc.[br][br]
##
## Dependencies: None. This is a standalone configuration resource.[br]
## Create via Resource menu and configure in the inspector.
class_name SSDMCanvasAnimatorConfig
extends Resource

## Dissolve pattern modes for shader-based dissolve effect.
enum DissolveMode { UV_SWEEP, NOISE, RADIAL }

@export_group("Slide Out")
@export var animate_slide_out: bool = false  ## Enable size animation (slide/reveal effect). WARNING: Cannot combine with Scale, Rotation, or Position animations.
@export var axis: SSDMGlobal.Axis = SSDMGlobal.Axis.VERTICAL  ## Direction of size animation. VERTICAL = slides down/up, HORIZONTAL = slides left/right.
@export var open_direction: SSDMGlobal.OpenDirection = SSDMGlobal.OpenDirection.POSITIVE  ## Which way the panel slides. POSITIVE = down/right, NEGATIVE = up/left.

@export_group("Transform Animations")
@export_subgroup("Scale")
@export var animate_scale: bool = false  ## Enable scale animation (grow/shrink effect). Can combine with Rotation and Position.
@export var scale_from: Vector2 = Vector2(0.1, 0.1)  ## Starting scale (1.0 = normal size). Values less than 1.0 start small, greater than 1.0 start large.
@export var scale_to: Vector2 = Vector2.ONE  ## Ending scale (1.0 = normal size). Animation tweens from scale_from to scale_to.
@export var scale_pivot_preset: SSDMGlobal.RotationPivot = SSDMGlobal.RotationPivot.CENTER  ## Point around which scaling occurs.

@export_subgroup("Rotation")
@export var animate_rotation: bool = false  ## Enable rotation animation (spin effect). Can combine with Scale and Position.
@export var rotation_from_degrees: float = 0.0  ## Starting rotation angle in degrees.
@export var rotation_to_degrees: float = 360.0  ## Ending rotation angle in degrees. Use 360 for a full spin.
@export var rotation_pivot_preset: SSDMGlobal.RotationPivot = SSDMGlobal.RotationPivot.CENTER  ## Point around which rotation occurs.

@export_subgroup("Position")
@export var animate_position: bool = false  ## Enable position animation (move/slide effect). Can combine with Scale and Rotation.
@export var position_offset: Vector2 = Vector2(20.0, 20.0)  ## Starting offset position in pixels. Animates to (0,0).

@export_group("Tween Visual Effects")
@export_subgroup("Fade")
@export var animate_fade: bool = false  ## Enable fade animation (transparency effect). Fades the entire element. Safe to combine with transforms.
@export var fade_from: float = 0.0  ## Starting opacity (0.0 = invisible, 1.0 = fully visible).
@export var fade_to: float = 1.0  ## Ending opacity.

@export_subgroup("Color")
@export var animate_color: bool = false  ## Enable color animation (background color tween). Only works on elements with StyleBoxFlat.
@export var color_from: Color = Color.WHITE  ## Starting background color.
@export var color_to: Color = Color.WHITE  ## Ending background color.

@export_subgroup("Shake")
@export var animate_shake: bool = false  ## Enable shake animation (vibration effect). Adds random position offsets for emphasis.
@export var shake_amount: float = 3.0  ## Maximum shake distance in pixels. Typical range: 2-10 pixels.
@export var shake_speed: float = 0.05  ## Time between shake updates in seconds. Typical range: 0.01-0.1 seconds.

@export_group("Shader Effects")
@export_subgroup("Glow")
@export var animate_glow: bool = false  ## Additive brightness overlay on opaque pixels.
@export var glow_intensity: float = 1.0  ## Glow brightness multiplier. Higher = brighter.
@export var glow_color: Color = Color.WHITE  ## Tint color added to the glow.

@export_subgroup("Pulse")
@export var animate_pulse: bool = false  ## Oscillates alpha using sin(TIME * pulse_speed).
@export var pulse_speed: float = 2.0  ## Cycles per second for the pulse.
@export var pulse_min_alpha: float = 0.2  ## Minimum alpha at the bottom of each pulse cycle.

@export_subgroup("Hue Shift")
@export var animate_hue_shift: bool = false  ## Continuously rotates the hue of opaque pixels.
@export var hue_shift_speed: float = 1.0  ## Hue rotation speed in full cycles per second.

@export_subgroup("Shimmer")
@export var animate_shimmer: bool = false  ## Diagonal highlight band that sweeps across.
@export var shimmer_speed: float = 2.0  ## How fast the shimmer band moves.
@export var shimmer_width: float = 0.2  ## Fractional width of the shimmer band (0-1).
@export var shimmer_brightness: float = 0.5  ## Additional brightness inside the shimmer band.

@export_subgroup("Outline")
@export var animate_outline: bool = false  ## Draws a colored outline around opaque pixels. Best for icons with alpha edges.
@export var outline_color: Color = Color.WHITE  ## Color of the outline.
@export var outline_size: float = 1.0  ## Outline thickness in texels.

@export_subgroup("Dissolve")
@export var animate_dissolve: bool = false  ## Reveals or hides using one of three dissolve patterns.
@export var dissolve_mode: DissolveMode = DissolveMode.UV_SWEEP  ## UV_SWEEP = left-to-right; NOISE = random threshold; RADIAL = from center outward.
@export var dissolve_speed: float = 1.0  ## How many seconds the full dissolve takes.
@export var dissolve_spread: float = 0.1  ## Edge softness of the dissolve transition.

@export_subgroup("Flicker")
@export var animate_flicker: bool = false  ## Randomly flickers alpha at a fixed rate.
@export var flicker_speed: float = 10.0  ## Flicker updates per second.
@export var flicker_min: float = 0.3  ## Minimum alpha during a dark flicker frame.

@export_group("Timing and Easing")
@export var animation_speed: float = 1.0  ## Duration of tween animations in seconds.
@export var transition_type: Tween.TransitionType = Tween.TRANS_CUBIC  ## Math curve for animation motion.
@export var ease_type_open: Tween.EaseType = Tween.EASE_OUT  ## Easing for opening/forward animation.
@export var ease_type_close: Tween.EaseType = Tween.EASE_IN  ## Easing for closing/reverse animation.

@export_group("Clipping")
@export var clip_mode: SSDMGlobal.ClipMode = SSDMGlobal.ClipMode.AUTO  ## AUTO = clips for slide/position, not for rotation. ALWAYS/NEVER override.

@export_group("Sizing")
@export var panel_width: float = 400.0  ## Width in pixels for horizontal slide animations.
