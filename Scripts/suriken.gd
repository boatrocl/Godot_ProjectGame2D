extends Area2D



func _ready() -> void:
	$AnimationPlayer.play("spine")
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player touch suriken")
