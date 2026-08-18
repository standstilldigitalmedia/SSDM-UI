extends Control

@export var animator: SSDMPanelShaderAnimatorBase

func _on_start_button_pressed() -> void:
	animator.play()


func _on_reverse_button_pressed() -> void:
	animator.reverse()


func _on_stop_button_pressed() -> void:
	animator.kill()
