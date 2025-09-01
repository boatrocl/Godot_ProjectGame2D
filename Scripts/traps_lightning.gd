extends Area2D

func _ready() -> void:
	var b = randf_range(2,8)
	await get_tree().create_timer(b).timeout
	$AnimationPlayer.play("Push")
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player touch trap lighting")
