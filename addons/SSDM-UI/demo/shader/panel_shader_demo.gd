extends PanelContainer

@export var dissolve_scene: SSDMUIDissolveScene
@export var color_scene: SSDMUIColorScene
@export var flicker_scene: SSDMUIFlickerScene
@export var hue_shift_scene: SSDMUIHueShiftScene
@export var pulse_scene: SSDMUIPulseScene
@export var shimmer_scene: SSDMUIShimmerScene


func _on_dissolve_start_button_pressed() -> void:
	dissolve_scene.play()


func _on_dissolve_stop_button_pressed() -> void:
	dissolve_scene.stop()
	
	
func _on_dissolve_reverse_button_pressed() -> void:
	dissolve_scene.reverse()
	
	
func _on_dissolve_speed_spin_box_value_changed(value: float) -> void:
	dissolve_scene.set_speed(value)


func _on_dissolve_mode_option_button_item_selected(index: int) -> void:
	dissolve_scene.set_mode(index)


func _on_dissolve_spread_spin_box_value_changed(value: float) -> void:
	dissolve_scene.set_spread(value)
	
	
func _on_dissolve_background_color_picker_button_color_changed(color: Color) -> void:
	dissolve_scene.set_background_color(color)
	
	
func _on_dissolve_trans_type_option_button_item_selected(index: int) -> void:
	dissolve_scene.set_transition_type(index)


func _on_dissolve_play_ease_type_option_button_item_selected(index: int) -> void:
	dissolve_scene.set_play_ease_type(index)


func _on_dissolve_reverse_ease_type_option_button_item_selected(index: int) -> void:
	dissolve_scene.set_reverse_ease_type(index)


func _on_flicker_start_button_pressed() -> void:
	flicker_scene.play()


func _on_flicker_stop_button_pressed() -> void:
	flicker_scene.stop()
	
	
func _on_flicker_speed_spin_box_value_changed(value: float) -> void:
	flicker_scene.set_speed(value)


func _on_flicker_min_alpha_spin_box_value_changed(value: float) -> void:
	flicker_scene.set_min_alpha(value)
	

func _on_flicker_duration_spin_box_value_changed(value: float) -> void:
	flicker_scene.set_duration(value)
	
	
func _on_flicker_background_color_picker_button_color_changed(color: Color) -> void:
	flicker_scene.set_background_color(color)


func _on_hue_shift_start_button_pressed() -> void:
	hue_shift_scene.play()


func _on_hue_shift_stop_button_pressed() -> void:
	hue_shift_scene.stop()
	

func _on_hue_shift_speed_spin_box_value_changed(value: float) -> void:
	hue_shift_scene.set_speed(value)
	

func _on_hue_shift_duration_spin_box_value_changed(value: float) -> void:
	hue_shift_scene.set_duration(value)


func _on_hue_shift_background_color_picker_button_color_changed(color: Color) -> void:
	hue_shift_scene.set_background_color(color)


func _on_pulse_start_button_pressed() -> void:
	pulse_scene.play()


func _on_pulse_stop_button_pressed() -> void:
	pulse_scene.stop()
	
	
func _on_pulse_speed_spin_box_value_changed(value: float) -> void:
	pulse_scene.set_speed(value)


func _on_pulse_min_alpha_spin_box_value_changed(value: float) -> void:
	pulse_scene.set_min_alpha(value)


func _on_pulse_duration_spin_box_value_changed(value: float) -> void:
	pulse_scene.set_duration(value)
	
	
func _on_pulse_background_color_picker_button_color_changed(color: Color) -> void:
	pulse_scene.set_background_color(color)


func _on_shimmer_start_button_pressed() -> void:
	shimmer_scene.play()


func _on_shimmer_stop_button_pressed() -> void:
	shimmer_scene.stop()


func _on_shimmer_speed_spin_box_value_changed(value: float) -> void:
	shimmer_scene.set_speed(value)


func _on_shimmer_width_spin_box_value_changed(value: float) -> void:
	shimmer_scene.set_width(value)


func _on_shimmer_brightness_spin_box_value_changed(value: float) -> void:
	shimmer_scene.set_brightness(value)


func _on_shimmer_duration_spin_box_value_changed(value: float) -> void:
	shimmer_scene.set_duration(value)
	

func _on_shimmer_background_color_picker_button_color_changed(color: Color) -> void:
	shimmer_scene.set_background_color(color)


func _on_color_start_button_pressed() -> void:
	color_scene.play()


func _on_color_stop_button_pressed() -> void:
	color_scene.stop()
	color_scene.set_background_color(color_scene.background_color)


func _on_color_reverse_button_pressed() -> void:
	color_scene.reverse()


func _on_color_speed_spin_box_value_changed(value: float) -> void:
	color_scene.set_speed(value)


func _on_color_to_picker_button_color_changed(color: Color) -> void:
	color_scene.set_to_color(color)


func _on_color_background_color_picker_button_color_changed(color: Color) -> void:
	color_scene.set_background_color(color)
	
	
func _on_color_trans_type_option_button_item_selected(index: int) -> void:
	color_scene.set_transition_type(index)


func _on_color_play_ease_type_option_button_item_selected(index: int) -> void:
	color_scene.set_play_ease_type(index)


func _on_color_reverse_ease_type_option_button_item_selected(index: int) -> void:
	color_scene.set_reverse_ease_type(index)
