extends Area2D

@export var next_scene : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().call_deferred("change_scene_to_file", next_scene)
		#get_tree().change_scene_to_file(str(next_scene))
		#get_tree().change_scene_to_packed(next_scene)
