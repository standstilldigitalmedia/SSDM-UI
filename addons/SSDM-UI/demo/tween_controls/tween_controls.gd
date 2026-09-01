class_name SSDMUITweenControls
extends GridContainer

signal transition_type_selected(new_type: int)
signal play_ease_type_selected(new_type: int)
signal reverse_ease_type_selected(new_type: int)

@export var transition_type_option_button: OptionButton
@export var play_ease_type_option_button: OptionButton
@export var reverse_ease_type_option_button: OptionButton
@export var play_ease_type_label: Label
@export var reverse_ease_type_label: Label


func _ui_set_transition_type() -> void:
	if transition_type_option_button.selected == SSDMUISingleControlTweenAnimatorBase.TransitionType.NONE:
		play_ease_type_option_button.select(SSDMUISingleControlTweenAnimatorBase.EaseType.None)
		reverse_ease_type_option_button.select(SSDMUISingleControlTweenAnimatorBase.EaseType.None)
		play_ease_type_label.hide()
		play_ease_type_option_button.hide()
		reverse_ease_type_label.hide()
		reverse_ease_type_option_button.hide()
	else:
		play_ease_type_label.show()
		play_ease_type_option_button.show()
		reverse_ease_type_label.show()
		reverse_ease_type_option_button.show()


func _on_transition_type_option_button_item_selected(index: int) -> void:
	transition_type_selected.emit(index)
	_ui_set_transition_type()
	

func _on_play_ease_type_option_button_item_selected(index: int) -> void:
	play_ease_type_selected.emit(index)
	_ui_set_transition_type()
	

func _on_reverse_ease_type_option_button_item_selected(index: int) -> void:
	reverse_ease_type_selected.emit(index)
	_ui_set_transition_type()
