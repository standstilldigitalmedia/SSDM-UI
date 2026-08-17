class_name SSDMPanelStep
extends Resource

@export_group("Panel Animation")
@export var panel_animation: SSDMCanvasAnimatorConfig  ## The panel animation configuration for this step. Leave null for no panel animation.
@export var panel_reverse: bool = false  ## If true, play the panel animation backwards (close-to-open direction).
@export var panel_duration: float = 0.0  ## 0 = loop until interrupted, >0 = play once for that duration.

@export_group("Timing")
@export var delay_before: float = 0.0  ## Delay in seconds before starting this animation step.
