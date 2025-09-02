extends Control

#@onready var score_texture = %Score/ScoreTexture
@onready var score_label = $ColorRect/Panel/ScoreLabel

func _process(_delta):
	# Set the score label text to the score variable in game maanger script
	score_label.text = "Score:%d" % GameManager.score


func _on_restart_pressed() -> void:
	GameManager.reset_score()
	get_tree().call_deferred("change_scene_to_file", "res://Scene/Level1.tscn")


func _on_menu_pressed() -> void:
	GameManager.reset_score()
	get_tree().call_deferred("change_scene_to_file", "res://Scene/Main Menu.tscn")
