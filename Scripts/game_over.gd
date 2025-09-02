extends Control

#@onready var score_texture = %Score/ScoreTexture
@onready var score_label = $ColorRect/Panel/ScoreLabel

func _process(_delta):
	# Set the score label text to the score variable in game maanger script
	score_label.text = "Score:%d" % GameManager.score
