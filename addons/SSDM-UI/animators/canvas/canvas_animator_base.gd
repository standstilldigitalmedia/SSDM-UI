class_name SSDMCanvasAnimatorBase
extends Control

@export var shader_material: ShaderMaterial

@export_group("Controls")
@export var wrapper: Control
@export var isolation: Control
@export var content_panel: PanelContainer


func _ready() -> void:
	wrapper.set_anchors_preset(0)
	wrapper.offset_right = 40.0
	wrapper.offset_bottom = 40.0
	wrapper.size_flags_horizontal = 3
	wrapper.size_flags_vertical = 4
	
	isolation.set_anchors_preset(15)
	isolation.anchor_right = 1.0
	isolation.anchor_bottom = 1.0
	isolation.grow_horizontal = 2
	isolation.grow_vertical = 2
	
	content_panel.set_anchors_preset(15)
	content_panel.anchor_right = 1.0
	content_panel.anchor_bottom = 1.0
	content_panel.grow_horizontal = 2
	content_panel.grow_vertical = 2
