class_name SSDMButtonStep
extends Resource

@export_group("Panel Animation")
@export var panel_animation: SSDMCanvasAnimatorConfig  ## Transform + visual + shader animations on the button body.
@export var panel_reverse: bool = false  ## If true, play the panel animation backwards.
@export var panel_duration: float = 0.0  ## 0 = loop until interrupted. >0 = play once (transforms) or for that duration (shaders).

@export_group("Text Animation")
@export var text_animation: SSDMTextAnimatorConfig  ## Shader effects + transforms on the button label.
@export var text_duration: float = 0.0  ## 0 = loop until interrupted. >0 = play for that duration then stop.

@export_group("Icon Animation")
@export var icon_animation: SSDMCanvasAnimatorConfig  ## Transform + visual + shader animations on the icon.
@export var icon_reverse: bool = false  ## If true, play the icon animation backwards.
@export var icon_duration: float = 0.0  ## 0 = loop until interrupted. >0 = play once (transforms) or for that duration (shaders).

@export_group("Timing")
@export var delay_before: float = 0.0  ## Delay in seconds before starting this animation step.
