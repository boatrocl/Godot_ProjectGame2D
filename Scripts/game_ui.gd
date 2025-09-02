extends Control

@onready var score_texture = %Score/ScoreTexture
@onready var score_label = %Score/ScoreLabel
@onready var hp1 = %Hp/HpTexture1
@onready var hp2 = %Hp/HpTexture2
@onready var hp3 = %Hp/HpTexture3
@onready var hp4 = %Hp/HpTexture4
@onready var hp5 = %Hp/HpTexture5

func _process(_delta):
	# Set the score label text to the score variable in game maanger script
	update_score()
	update_hp()

func update_score():
	score_label.text = "x %d" % GameManager.score

func update_hp():
	hp1.visible = GameManager.player_hp >= 1
	hp2.visible = GameManager.player_hp >= 2
	hp3.visible = GameManager.player_hp >= 3
	hp4.visible = GameManager.player_hp >= 4
	hp5.visible = GameManager.player_hp >= 5
