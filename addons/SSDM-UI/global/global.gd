class_name SSDMUIGlobal
extends RefCounted

enum RotationPivot 
{
	TOP_LEFT,
	TOP_CENTER,
	TOP_RIGHT,
	CENTER_LEFT,
	CENTER,
	CENTER_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_CENTER,
	BOTTOM_RIGHT,
}

enum TransitionType
{
	Back,
	Bounce,
	Circ,
	Cubic,
	Elastic,
	Expo,
	Linear,
	Quad,
	Quart,
	Quint,
	Sine,
	Spring,
	None,
}

enum EaseType
{
	Ease_In,
	Ease_In_Out,
	Ease_Out,
	Ease_Out_In,
	None,
}

enum OpenDirection 
{
	POSITIVE,
	NEGATIVE,
}

enum Axis 
{
	VERTICAL,
	HORIZONTAL,
}

enum Mode 
{ 
	UV_SWEEP, 
	NOISE, 
	RADIAL 
}

const SHADER_PARAMETER: String = "shader_parameter/"
const BACKGROUND_COLOR: String = "bg_color"
const PANEL_THEME: String = "panel"

const FLICKER_ENABLED: String = "flicker_enabled"
const FLICKER_SPEED: String = "flicker_speed"
const FLICKER_MIN_ALPHA: String = "flicker_min_alpha"

const HUE_SHIFT_ENABLED: String = "hue_shift_enabled"
const HUE_SHIFT_SPEED: String = "hue_shift_speed"

const PULSE_ENABLED: String = "pulse_enabled"
const PULSE_SPEED: String = "pulse_speed"
const PULSE_MIN_ALPHA: String = "pulse_min_alpha"

const SHIMMER_ENABLED: String = "shimmer_enabled"
const SHIMMER_SPEED: String = "shimmer_speed"
const SHIMMER_WIDTH: String = "shimmer_width"
const SHIMMER_BRIGHTNESS: String = "shimmer_brightness"

const COLOR_ENABLED: String = "color_enabled"

const DISSOLVE_ENABLED: String = "dissolve_enabled"
const DISSOLVE_MODE: String = "dissolve_mode"
const DISSOLVE_PROGRESS: String = "dissolve_progress"
const DISSOLVE_SPREAD: String = "dissolve_spread"

const POSITION_PROPERTY: String = "position"
const ROTATION_PROPERTY: String = "rotation"
const SCALE_PROPERTY: String = "scale"
const POSITION_X_PROPERTY: String = "position:x"
const TRANSFORM_X_PROPERTY: String = "custom_minimum_size:x"
const TRANSFORM_Y_PROPERTY: String = "custom_minimum_size:y"
