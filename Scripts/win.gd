extends Control

#@onready var score_texture = %Score/ScoreTexture
@onready var score_label = $Panel/Score
@onready var victory_sound = $AudioStreamPlayer

func _ready() -> void:
	victory_sound.play()

func _process(_delta):
	# Set the score label text to the score variable in game maanger script
	score_label.text = "Score:%d" % GameManager.score

func _on_menu_pressed() -> void:
	GameManager.reset_score()
	get_tree().call_deferred("change_scene_to_file", "res://Scene/Main Menu.tscn")


func _on_newgame_pressed() -> void:
	GameManager.reset_score()
	get_tree().call_deferred("change_scene_to_file", "res://Scene/Level1.tscn")
