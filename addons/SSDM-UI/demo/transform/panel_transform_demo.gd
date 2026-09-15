extends PanelContainer

@export var position_scene: SSDMUIPositionScene
@export var rotation_scene: SSDMUIRotateScene
@export var scale_scene: SSDMUIScaleScene
@export var shake_scene: SSDMUIShakeScene
@export var slide_scene: SSDMUISlideOutScene


func _on_position_play_button_pressed() -> void:
	position_scene.play()


func _on_position_reverse_button_pressed() -> void:
	position_scene.reverse()


func _on_position_speed_spin_box_value_changed(value: float) -> void:
	position_scene.set_speed(value)
	
	
func _on_position_x_offset_spin_box_value_changed(value: float) -> void:
	position_scene.set_x_offset(value)


func _on_postion_y_offset_spin_box_value_changed(value: float) -> void:
	position_scene.set_y_offset(value)


func _on_position_trans_type_option_button_item_selected(index: int) -> void:
	position_scene.set_transition_type(index)


func _on_position_play_ease_type_option_button_item_selected(index: int) -> void:
	position_scene.set_play_ease_type(index)


func _on_position_reverse_ease_type_option_button_item_selected(index: int) -> void:
	position_scene.set_reverse_ease_type(index)


func _on_position_background_color_picker_button_color_changed(color: Color) -> void:
	position_scene.set_background_color(color)


func _on_rotation_play_button_pressed() -> void:
	rotation_scene.play()


func _on_rotation_reverse_button_pressed() -> void:
	rotation_scene.reverse()


func _on_rotation_speed_spin_box_value_changed(value: float) -> void:
	rotation_scene.set_speed(value)


func _on_rotation_to_spin_box_value_changed(value: float) -> void:
	rotation_scene.set_to_degrees(value)


func _on_rotation_from_spin_box_value_changed(value: float) -> void:
	rotation_scene.set_from_degrees(value)


func _on_rotation_pivot_option_button_item_selected(index: int) -> void:
	rotation_scene.set_pivot_preset(index)


func _on_rotation_background_color_picker_button_color_changed(color: Color) -> void:
	rotation_scene.set_background_color(color)


func _on_rotation_trans_type_option_button_item_selected(index: int) -> void:
	rotation_scene.set_transition_type(index)


func _on_rotation_play_ease_type_option_button_item_selected(index: int) -> void:
	rotation_scene.set_play_ease_type(index)


func _on_rotation_reverse_ease_type_option_button_item_selected(index: int) -> void:
	rotation_scene.set_reverse_ease_type(index)


func _on_scale_play_button_pressed() -> void:
	scale_scene.play()


func _on_scale_reverse_button_pressed() -> void:
	scale_scene.reverse()


func _on_scale_speed_spin_box_value_changed(value: float) -> void:
	scale_scene.set_speed(value)


func _on_scale_pivot_option_button_item_selected(index: int) -> void:
	scale_scene.set_pivot_preset(index)


func _on_scale_from_x_spin_box_value_changed(value: float) -> void:
	scale_scene.set_x_scale_from(value)


func _on_scale_from_y_spin_box_value_changed(value: float) -> void:
	scale_scene.set_y_scale_from(value)


func _on_scale_to_x_spin_box_value_changed(value: float) -> void:
	scale_scene.set_x_scale_to(value)


func _on_scale_to_y_spin_box_value_changed(value: float) -> void:
	scale_scene.set_y_scale_to(value)


func _on_scale_background_color_picker_button_color_changed(color: Color) -> void:
	scale_scene.set_background_color(color)


func _on_scale_trans_type_option_button_item_selected(index: int) -> void:
	scale_scene.set_transition_type(index)


func _on_scale_play_ease_type_option_button_item_selected(index: int) -> void:
	scale_scene.set_play_ease_type(index)


func _on_scale_reverse_ease_type_option_button_item_selected(index: int) -> void:
	scale_scene.set_reverse_ease_type(index)


func _on_shake_play_button_pressed() -> void:
	shake_scene.play()


func _on_shake_speed_spin_box_value_changed(value: float) -> void:
	shake_scene.set_speed(value)


func _on_shake_amount_spin_box_value_changed(value: float) -> void:
	shake_scene.set_amount(value)


func _on_shake_background_color_picker_button_color_changed(color: Color) -> void:
	shake_scene.set_background_color(color)
	
	
func _on_shake_trans_type_option_button_item_selected(index: int) -> void:
	shake_scene.set_transition_type(index)


func _on_shake_play_ease_type_option_button_item_selected(index: int) -> void:
	shake_scene.set_play_ease_type(index)


func _on_shake_reverse_ease_type_option_button_item_selected(index: int) -> void:
	shake_scene.set_reverse_ease_type(index)


func _on_slide_play_button_pressed() -> void:
	slide_scene.play()


func _on_slide_reverse_button_pressed() -> void:
	slide_scene.reverse()


func _on_slide_speed_spin_box_value_changed(value: float) -> void:
	slide_scene.set_speed(value)


func _on_slide_axis_option_button_item_selected(index: int) -> void:
	slide_scene.set_axis(index)


func _on_slide_open_direction_option_button_item_selected(index: int) -> void:
	slide_scene.set_open_direction(index)


func _on_slide_panel_width_spin_box_value_changed(value: float) -> void:
	slide_scene.set_panel_width(value)


func _on_slide_background_color_picker_button_color_changed(color: Color) -> void:
	slide_scene.set_background_color(color)


func _on_slide_trans_type_option_button_item_selected(index: int) -> void:
	slide_scene.set_transition_type(index)


func _on_slide_play_ease_type_option_button_item_selected(index: int) -> void:
	slide_scene.set_play_ease_type(index)


func _on_slide_reverse_ease_type_option_button_item_selected(index: int) -> void:
	slide_scene.set_reverse_ease_type(index)
