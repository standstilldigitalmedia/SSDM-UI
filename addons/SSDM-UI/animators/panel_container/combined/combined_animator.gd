class_name SSDMUICombinedAnimator
extends Control

@export_category("Shader Animation")
@export_group("Flicker")
@export var flicker_enabled: bool = false
@export var flicker_speed: float = 1.0
@export var flicker_min_alpha: float = 0.0
@export_group("Hue Shift")
@export var hue_shift_enabled: bool
@export var hue_shift_speed: float = 1.0
@export_group("Pulse")
@export var pulse_enabled: bool = false
@export var pulse_speed: float = 1.0
@export var pulse_min_alpha: float = 0.0
@export_group("Shimmer")
@export var shimmer_enabled: bool = false
@export var shimmer_speed: float = 1.0
@export var shimmer_width: float = 0.1
@export var shimmer_brightness: float = 1.0
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
@export var position_enabled: bool = false:
	set(value):
		if value == position_enabled:
			return
		if shake_enabled or slide_enabled:
			position_enabled = false
			return
		position_enabled = value
@export var position_offset: Vector2 = Vector2(20.0, 20.0)
@export var position_speed: float = 1.0
@export_group("Rotate")
@export var rotate_enabled: bool = false:
	set(value):
		if value == rotate_enabled:
			return
		if shake_enabled or slide_enabled:
			rotate_enabled = false
			return
		rotate_enabled = value
@export var rotate_from_degrees: float = 0.0
@export var rotate_to_degrees: float = 360.0 
@export var rotate_pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
@export var rotate_speed: float = 1.0
@export_group("Scale")
@export var scale_enabled: bool = false:
	set(value):
		if value == scale_enabled:
			return
		if shake_enabled or slide_enabled:
			scale_enabled = false
			return
		scale_enabled = value
@export var scale_from: Vector2 = Vector2.ONE
@export var scale_to: Vector2 = Vector2(0.0, 0.0)
@export var scale_pivot_preset: SSDMUIGlobal.RotationPivot = SSDMUIGlobal.RotationPivot.CENTER
@export var scale_speed: float = 1.0
@export_group("Shake")
@export var shake_enabled: bool = false:
	set(value):
		if value == shake_enabled:
			return
		shake_enabled = value
		if shake_enabled:
			position_enabled = false
			rotate_enabled = false
			scale_enabled = false
			slide_enabled = false
@export var shake_amount: float = 3.0
@export var shake_speed: float = 1.0
@export_group("Slide")
@export var slide_enabled: bool = false:
	set(value):
		if value == slide_enabled:
			return
		slide_enabled = value
		if slide_enabled:
			position_enabled = false
			rotate_enabled = false
			scale_enabled = false
			shake_enabled = false
@export var slide_start_full: bool = false
@export var slide_axis: SSDMUIGlobal.Axis = SSDMUIGlobal.Axis.HORIZONTAL
@export var slide_open_direction: SSDMUIGlobal.OpenDirection = SSDMUIGlobal.OpenDirection.POSITIVE
@export var slide_panel_width: float = 200.0
@export var slide_speed: float = 1.0
@export_category("Transistion and Easing")
@export var transition_type: SSDMUIGlobal.TransitionType = SSDMUIGlobal.TransitionType.None:
	set(value):
		if value == transition_type:
			return
		transition_type = value
		if transition_type == SSDMUIGlobal.TransitionType.None:
			ease_type_play = SSDMUIGlobal.EaseType.None
			ease_type_reverse = SSDMUIGlobal.EaseType.None
@export var ease_type_play: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None:
	set(value):
		if value == ease_type_play:
			return
		if transition_type == SSDMUIGlobal.TransitionType.None:
			ease_type_play = SSDMUIGlobal.EaseType.None
			return
		ease_type_play = value
@export var ease_type_reverse: SSDMUIGlobal.EaseType = SSDMUIGlobal.EaseType.None:
	set(value):
		if value == ease_type_reverse:
			return
		if transition_type == SSDMUIGlobal.TransitionType.None:
			ease_type_reverse = SSDMUIGlobal.EaseType.None
			return
		ease_type_reverse = value
