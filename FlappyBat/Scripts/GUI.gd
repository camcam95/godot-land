extends Control

signal start

func _on_start_button_pressed() -> void:
	start.emit()
