class_name SSDMUITweenControls
extends CenterContainer

signal transition_type_selected(new_type: int)
signal play_ease_type_selected(new_type: int)
signal reverse_ease_type_selected(new_type: int)

@export var transition_type_option_button: OptionButton
@export var play_ease_type_option_button: OptionButton
@export var reverse_ease_type_option_button: OptionButton


func _on_transition_type_option_button_item_selected(index: int) -> void:
	transition_type_selected.emit(index)
	if play_ease_type_option_button.selected == SSDMUISingleControlTweenAnimatorBase.EASE_TYPE_NONE:
		play_ease_type_option_button.select(0)
	if reverse_ease_type_option_button.selected == SSDMUISingleControlTweenAnimatorBase.EASE_TYPE_NONE:
		reverse_ease_type_option_button.select(1)


func _on_play_ease_type_option_button_item_selected(index: int) -> void:
	play_ease_type_selected.emit(index)
	if transition_type_option_button.selected == SSDMUISingleControlTweenAnimatorBase.TRANSISTION_TYPE_NONE:
		transition_type_option_button.select(7)


func _on_reverse_ease_type_option_button_item_selected(index: int) -> void:
	reverse_ease_type_selected.emit(index)
	if transition_type_option_button.selected == SSDMUISingleControlTweenAnimatorBase.TRANSISTION_TYPE_NONE:
		transition_type_option_button.select(7)
