extends Node2D

var score : int = 0
var spawn_point : Vector2
var player_hp : int = 5


func add_score():
	score += 1
	print(score)

func set_spawn_point(spawn_pos : Vector2):
	spawn_point = spawn_pos

func take_damage():
	player_hp -= 1
	print("player hp" + str(player_hp))
	if player_hp == 0:
		#get_tree().change_scene_to_file("res://Scene/game_over.tscn")
		#$Player/AnimatedSprite2D.play("die")
		get_tree().call_deferred("change_scene_to_file", "res://Scene/game_over.tscn")

func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
