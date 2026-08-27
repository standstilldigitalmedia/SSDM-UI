extends PanelContainer

@export var dissolve_animator: SSDMUIControlDissolveAnimator
@export var color_animator: SSDMUIControlColorAnimator
@export var flicker_animator: SSDMUIControlFlickerAnimator
@export var hue_shift_animator: SSDMUIControlHueShiftAnimator
@export var pulse_animator: SSDMUIControlPulseAnimator
@export var shimmer_animator: SSDMUIControlShimmerAnimator


func _on_dissolve_start_button_pressed() -> void:
	dissolve_animator.play()


func _on_dissolve_stop_button_pressed() -> void:
	dissolve_animator.kill()
	
	
func _on_dissolve_reverse_button_pressed() -> void:
	dissolve_animator.reverse()
	
	
func _on_dissolve_speed_spin_box_value_changed(value: float) -> void:
	dissolve_animator.set_speed(value)


func _on_dissolve_mode_option_button_item_selected(index: int) -> void:
	dissolve_animator.set_mode(index)


func _on_dissolve_spread_spin_box_value_changed(value: float) -> void:
	dissolve_animator.set_spread(value)
	
	
func _on_dissolve_background_color_picker_button_color_changed(color: Color) -> void:
	dissolve_animator.set_background_color(color)


func _on_flicker_start_button_pressed() -> void:
	flicker_animator.play()


func _on_flicker_stop_button_pressed() -> void:
	flicker_animator.kill()
	
	
func _on_flicker_speed_spin_box_value_changed(value: float) -> void:
	flicker_animator.set_speed(value)


func _on_flicker_min_alpha_spin_box_value_changed(value: float) -> void:
	flicker_animator.set_min_alpha(value)
	

func _on_flicker_duration_spin_box_value_changed(value: float) -> void:
	flicker_animator.set_duration(value)
	
	
func _on_flicker_background_color_picker_button_color_changed(color: Color) -> void:
	flicker_animator.set_background_color(color)


func _on_hue_shift_start_button_pressed() -> void:
	hue_shift_animator.play()


func _on_hue_shift_stop_button_pressed() -> void:
	hue_shift_animator.kill()
	

func _on_hue_shift_speed_spin_box_value_changed(value: float) -> void:
	hue_shift_animator.set_speed(value)
	

func _on_hue_shift_duration_spin_box_value_changed(value: float) -> void:
	hue_shift_animator.set_duration(value)


func _on_hue_shift_background_color_picker_button_color_changed(color: Color) -> void:
	hue_shift_animator.set_background_color(color)


func _on_pulse_start_button_pressed() -> void:
	pulse_animator.play()


func _on_pulse_stop_button_pressed() -> void:
	pulse_animator.kill()
	
	
func _on_pulse_speed_spin_box_value_changed(value: float) -> void:
	pulse_animator.set_speed(value)


func _on_pulse_min_alpha_spin_box_value_changed(value: float) -> void:
	pulse_animator.set_min_alpha(value)


func _on_pulse_duration_spin_box_value_changed(value: float) -> void:
	pulse_animator.set_duration(value)
	
	
func _on_pulse_background_color_picker_button_color_changed(color: Color) -> void:
	pulse_animator.set_background_color(color)


func _on_shimmer_start_button_pressed() -> void:
	shimmer_animator.play()


func _on_shimmer_stop_button_pressed() -> void:
	shimmer_animator.kill()


func _on_shimmer_speed_spin_box_value_changed(value: float) -> void:
	shimmer_animator.set_speed(value)


func _on_shimmer_width_spin_box_value_changed(value: float) -> void:
	shimmer_animator.set_width(value)


func _on_shimmer_brightness_spin_box_value_changed(value: float) -> void:
	shimmer_animator.set_brighness(value)


func _on_shimmer_duration_spin_box_value_changed(value: float) -> void:
	shimmer_animator.set_duration(value)
	

func _on_shimmer_background_color_picker_button_color_changed(color: Color) -> void:
	shimmer_animator.set_background_color(color)


func _on_color_start_button_pressed() -> void:
	color_animator.play()


func _on_color_stop_button_pressed() -> void:
	color_animator.kill()


func _on_color_reverse_button_pressed() -> void:
	color_animator.reverse()


func _on_color_speed_spin_box_value_changed(value: float) -> void:
	color_animator.set_speed(value)


func _on_color_to_picker_button_color_changed(color: Color) -> void:
	color_animator.to_color = color


func _on_color_background_color_picker_button_color_changed(color: Color) -> void:
	color_animator.background_color = color
	color_animator.set_background_color(color)
