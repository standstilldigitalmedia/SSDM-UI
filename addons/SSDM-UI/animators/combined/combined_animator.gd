class_name SSDMUICombinedAnimator
extends Control

@export var background_color: Color = Color(1.0, 1.0, 1.0, 1.0)
@export_category("Shader Animation")
@export_group("RGB")
@export_subgroup("Hue Shift")
@export var hue_shift_enabled: bool
@export var hue_shift_speed: float = 1.0
@export var hue_shift_duration: float = 0.0
@export_subgroup("Shimmer")
@export var shimmer_enabled: bool = false
@export var shimmer_speed: float = 1.0
@export var shimmer_width: float = 0.1
@export var shimmer_brightness: float = 1.0
@export var shimmer_duration: float = 0.0
@export_subgroup("Color")
@export var color_enabled: bool = false
@export var to_color: Color = Color(0,0,0,1)
@export var color_speed: float = 1.0
@export_group("Alpha")
@export_subgroup("Flicker")
@export var flicker_enabled: bool = false
@export var flicker_speed: float = 1.0
@export var flicker_min_alpha: float = 0.0
@export var flicker_duration: float = 0.0
@export_subgroup("Pulse")
@export var pulse_enabled: bool = false
@export var pulse_speed: float = 1.0
@export var pulse_min_alpha: float = 0.0
@export var pulse_duration: float = 0.0
@export_subgroup("Dissolve")
@export var dissolve_enabled: bool = false
@export var dissolve_mode: SSDMUIGlobal.Mode = SSDMUIGlobal.Mode.NOISE
@export var dissolve_spread: float = 0.0
@export var dissolve_speed: float = 1.0
@export_category("Transform Animation")
@export_group("Combinable")
@export_subgroup("Position")
@export var position_enabled: bool = false
@export var position_offset: Vector2 = Vector2(20.0, 20.0)
@export var position_duration: float = 1.0
@export_subgroup("Rotate")
@export var rotate_enabled: bool = false
@export var rotate_from_degrees: float = 0.0
@export var rotate_to_degrees: float = 360.0 
@export var rotate_pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
@export var rotate_duration: float = 1.0
@export_subgroup("Scale")
@export var scale_enabled: bool = false
@export var scale_from: Vector2 = Vector2.ONE
@export var scale_to: Vector2 = Vector2(0.0, 0.0)
@export var scale_pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
@export var scale_duration: float = 1.0
@export_group("Not Combinable")
@export_subgroup("Shake")
@export var shake_enabled: bool = false
@export var shake_amount: float = 3.0
@export var shake_duration: float = 1.0
@export_subgroup("Slide")
@export var slide_enabled: bool = false
@export var slide_start_full: bool = false
@export var slide_axis: SSDMUIGlobal.Axis = SSDMUIGlobal.Axis.HORIZONTAL
@export var slide_open_direction: SSDMUIGlobal.OpenDirection = SSDMUIGlobal.OpenDirection.POSITIVE
@export var slide_panel_width: float = 200.0
@export var slide_duration: float = 1.0
@export_category("Transistion and Easing")
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export_category("Controls")
@export var material_target: Control
@export var shader_material: ShaderMaterial
@export var content: Control
@export var panel_container: PanelContainer
@export var isolation: Control

var flicker_animator: SSDMUIFlickerAnimator
var hue_shift_animator: SSDMUIHueShiftAnimator
var pulse_animator: SSDMUIPulseAnimator
var shimmer_animator: SSDMUIShimmerAnimator

var position_animator: SSDMUIPositionAnimator
var rotate_animator: SSDMUIRotateAnimator
var scale_animator: SSDMUIScaleAnimator
var shake_animator: SSDMUIShakeAnimator
var slide_animator: SSDMUISlideOutAnimator

var color_animator: SSDMUIColorAnimator
var dissolve_animator: SSDMUIDissolveAnimator


func _ready() -> void:
	flicker_animator = SSDMUIFlickerAnimator.new(material_target, shader_material, SSDMUIGlobal.FLICKER_SPEED, SSDMUIGlobal.FLICKER_ENABLED, background_color, flicker_speed, flicker_duration)
	hue_shift_animator = SSDMUIHueShiftAnimator.new(material_target, shader_material, SSDMUIGlobal.HUE_SHIFT_SPEED, SSDMUIGlobal.HUE_SHIFT_ENABLED, background_color, hue_shift_speed, hue_shift_duration)
	pulse_animator = SSDMUIPulseAnimator.new(material_target, shader_material, SSDMUIGlobal.PULSE_SPEED, SSDMUIGlobal.PULSE_ENABLED, background_color, pulse_speed, pulse_duration)
	shimmer_animator = SSDMUIShimmerAnimator.new(material_target, shader_material, SSDMUIGlobal.SHIMMER_SPEED, SSDMUIGlobal.SHIMMER_ENABLED, background_color, shimmer_speed, shimmer_duration)
	
	position_animator = SSDMUIPositionAnimator.new(panel_container, SSDMUIGlobal.POSITION_PROPERTY, Vector2.ZERO, position_offset, position_duration, panel_container)
	rotate_animator = SSDMUIRotateAnimator.new(panel_container, SSDMUIGlobal.ROTATION_PROPERTY, rotate_from_degrees, rotate_to_degrees, rotate_duration, panel_container)
	scale_animator = SSDMUIScaleAnimator.new(panel_container, SSDMUIGlobal.SCALE_PROPERTY, scale_from, scale_to, scale_duration, panel_container)
	shake_animator = SSDMUIShakeAnimator.new(panel_container, "", 0, 0, shake_duration, panel_container)
	slide_animator = SSDMUISlideOutAnimator.new(panel_container, "", 0, 0, slide_duration, panel_container)
	
	color_animator = SSDMUIColorAnimator.new()
	color_animator.init_shader(material_target, shader_material, "", SSDMUIGlobal.COLOR_ENABLED, background_color, color_speed, color_speed)
	color_animator.init_tween(shader_material, SSDMUIGlobal.BACKGROUND_COLOR, background_color, to_color, color_speed, panel_container, transition_type, ease_type_play, ease_type_reverse)
	dissolve_animator = SSDMUIDissolveAnimator.new()
	dissolve_animator.init_shader(material_target, shader_material, "", SSDMUIGlobal.DISSOLVE_ENABLED, background_color, dissolve_speed, dissolve_speed)
	dissolve_animator.init_tween(shader_material, SSDMUIGlobal.BACKGROUND_COLOR, 0, 0, dissolve_speed, panel_container, transition_type, ease_type_play, ease_type_reverse)
	
	flicker_animator.set_min_alpha(flicker_min_alpha)
	pulse_animator.set_min_alpha(pulse_min_alpha)
	shimmer_animator.set_width(shimmer_width)
	shimmer_animator.set_brightness(shimmer_brightness)
	
	rotate_animator.set_isolation(isolation)
	scale_animator.set_panel_container(panel_container)
	
	play()
	
	
func play() -> void:
	if flicker_enabled:
		flicker_animator.play()
	if hue_shift_enabled:
		hue_shift_animator.play()
	if pulse_enabled:
		pulse_animator.play()
	if shimmer_enabled:
		shimmer_animator.play()
		
	if position_enabled or rotate_enabled or scale_enabled:
		var new_tween: Tween = SSDMUITweenAnimatorBase.create_tween(self, transition_type, ease_type_play, true)
		if position_enabled:
			position_animator.set_tween(new_tween)
			position_animator.play()
		if rotate_enabled:
			rotate_animator.set_tween(new_tween)
			rotate_animator.play()
		if scale_enabled:
			scale_animator.set_tween(new_tween)
			scale_animator.play()
	
