extends Area2D

signal hit

const SPEED: float = 150.0

func _ready() -> void:
	position.y = randi_range(200, -200)
	position.x = 784

func _process(delta: float) -> void:
	position.x -= SPEED * delta

func _on_body_entered(_body: Node2D) -> void:
	hit.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
