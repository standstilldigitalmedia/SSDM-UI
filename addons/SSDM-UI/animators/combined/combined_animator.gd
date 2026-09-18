class_name SSDMUICombinedAnimator
extends Control

@export var background_color: Color = Color(1.0, 1.0, 1.0, 1.0)
@export_category("Shader Animation")
@export_group("Flicker")
@export var flicker_enabled: bool = false
@export var flicker_speed: float = 1.0
@export var flicker_min_alpha: float = 0.0
@export var flicker_duration: float = 0.0
@export_group("Hue Shift")
@export var hue_shift_enabled: bool
@export var hue_shift_speed: float = 1.0
@export var hue_shift_duration: float = 0.0
@export_group("Pulse")
@export var pulse_enabled: bool = false
@export var pulse_speed: float = 1.0
@export var pulse_min_alpha: float = 0.0
@export var pulse_duration: float = 0.0
@export_group("Shimmer")
@export var shimmer_enabled: bool = false
@export var shimmer_speed: float = 1.0
@export var shimmer_width: float = 0.1
@export var shimmer_brightness: float = 1.0
@export var shimmer_duration: float = 0.0
@export_group("Color")
@export var color_enabled: bool = false
@export var to_color: Color = Color(0,0,0,1)
@export var color_speed: float = 1.0
@export_group("Dissolve")
@export var dissolve_enabled: bool = false
@export var dissolve_mode: SSDMUIGlobal.Mode = SSDMUIGlobal.Mode.NOISE
@export var dissolve_spread: float = 0.0
@export var dissolve_speed: float = 1.0
@export_category("Transform Animation")
@export_group("Position")
@export var position_enabled: bool = false
@export var position_offset: Vector2 = Vector2(20.0, 20.0)
@export var position_speed: float = 1.0
@export_group("Rotate")
@export var rotate_enabled: bool = false
@export var rotate_from_degrees: float = 0.0
@export var rotate_to_degrees: float = 360.0 
@export var rotate_pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
@export var rotate_speed: float = 1.0
@export_group("Scale")
@export var scale_enabled: bool = false
@export var scale_from: Vector2 = Vector2.ONE
@export var scale_to: Vector2 = Vector2(0.0, 0.0)
@export var scale_pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
@export var scale_speed: float = 1.0
@export_group("Shake")
@export var shake_enabled: bool = false
@export var shake_amount: float = 3.0
@export var shake_speed: float = 1.0
@export_group("Slide")
@export var slide_enabled: bool = false
@export var slide_start_full: bool = false
@export var slide_axis: SSDMUIGlobal.Axis = SSDMUIGlobal.Axis.HORIZONTAL
@export var slide_open_direction: SSDMUIGlobal.OpenDirection = SSDMUIGlobal.OpenDirection.POSITIVE
@export var slide_panel_width: float = 200.0
@export var slide_speed: float = 1.0
@export_category("Transistion and Easing")
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None
@export_group("Controls")
@export var animation_target: Control
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
	flicker_animator = SSDMUIFlickerAnimator.new(animation_target, shader_material, SSDMUIGlobal.FLICKER_SPEED, SSDMUIGlobal.FLICKER_ENABLED, flicker_speed, background_color, flicker_duration)
	hue_shift_animator = SSDMUIHueShiftAnimator.new(animation_target, shader_material, SSDMUIGlobal.HUE_SHIFT_SPEED, SSDMUIGlobal.HUE_SHIFT_ENABLED, hue_shift_speed, background_color, hue_shift_duration)
	pulse_animator = SSDMUIPulseAnimator.new(animation_target, shader_material, SSDMUIGlobal.PULSE_SPEED, SSDMUIGlobal.PULSE_ENABLED, pulse_speed, background_color, pulse_duration)
	shimmer_animator = SSDMUIShimmerAnimator.new(animation_target, shader_material, SSDMUIGlobal.SHIMMER_SPEED, SSDMUIGlobal.SHIMMER_ENABLED, shimmer_speed, background_color, shimmer_duration)
	
	position_animator = SSDMUIPositionAnimator.new(self, self, SSDMUIGlobal.POSITION_PROPERTY, position_speed, Vector2.ZERO, position_offset)
	rotate_animator = SSDMUIRotateAnimator.new(self, self, SSDMUIGlobal.ROTATION_PROPERTY, rotate_speed, rotate_from_degrees, rotate_to_degrees)
	scale_animator = SSDMUIScaleAnimator.new(self, self, SSDMUIGlobal.SCALE_PROPERTY, scale_speed, scale_from, scale_to)
	shake_animator = SSDMUIShakeAnimator.new(self, self, "", shake_speed, 0, 0)
	slide_animator = SSDMUISlideOutAnimator.new(self, self, "", slide_speed, 0, 0)
	
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
	
