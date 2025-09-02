extends CharacterBody2D

var spd = 100
var end_path = 0

func _process(delta: float) -> void:
	$AnimatedSprite2D.play("run")
	velocity.x= spd 
	move_and_slide()
	
	if position.x == end_path:
		spd = spd*-1
	if spd <0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	

func _on_timer_timeout() -> void:
	end_path = position.x
