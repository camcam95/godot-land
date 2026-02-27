extends Node

const OBSTACLE_SCENE = preload("res://Scenes/Obstacle.tscn")

var score: int = 0
var multiplier: int = 10

func _ready() -> void:
	$Player.hide()
	$Player.set_physics_process(false)
	$GUI/ScoreLabel.hide()

func _on_obstacle_spawn_timer_timeout() -> void:
	spawn_new_obstacle()

func _on_score_timer_timeout() -> void:
	score += 1 * multiplier
	$GUI/ScoreLabel.text = "SCORE: " + str(score)

func _on_gui_start() -> void:
	new_game()

func game_over() -> void:
	$Player.hide()
	$Player.set_physics_process(false)
	$Player.get_tree().set_deferred("CollsionShape2D", "disabled")
	$GUI/ScoreLabel.hide()
	$GUI/Message.text = "GAME OVER\nFinal Score: " + str(score) + "\n\nPlay again?"
	$GUI/Message.show()
	$ObstacleSpawnTimer.stop()
	$GUI/StartButton.show()
	
	
	
func spawn_new_obstacle() -> void:
	var ob = OBSTACLE_SCENE.instantiate()
	ob.connect("hit", game_over)
	add_child(ob)

func new_game() -> void:
	$GUI/Message.text = "Get Ready..."
	$GUI/ScoreLabel.text = "SCORE: --"
	$GUI/StartButton.hide()
	$GUI/ScoreLabel.show()
	$StartTimer.start()
	await $StartTimer.timeout
	$Player.position = $PlayerStartPosition.position
	$Player.show()
	$Player.set_physics_process(true)
	$Player.get_tree().set_deferred("CollisionShape2D", "enabled")
	$GUI/Message.hide()
	$ObstacleSpawnTimer.start()
	$ScoreTimer.start()

	
	
