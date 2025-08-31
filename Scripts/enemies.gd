extends CharacterBody2D

const GRAVITY = 980 
var bullet_path = preload("res://Scene/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if $BulletTimer.is_stopped():
		$AnimatedSprite2D.play("idle")
	
	
	move_and_slide()

func _on_player_detection_area_body_entered(body: Node2D) -> void:
	print("detect")
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("attack")
		$BulletTimer.start()

func _on_player_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AnimatedSprite2D.stop()
		$BulletTimer.stop()

func _on_bullet_timer_timeout() -> void:
	fire()

func fire():
	var bullet = bullet_path.instantiate()
	bullet.add_to_group("player_bullet")
	if $AnimatedSprite2D.flip_h == false:
		bullet.rota = deg_to_rad(0)
	elif $AnimatedSprite2D.flip_h == true:
		bullet.rota = deg_to_rad(180)
	bullet.pos = $FiringPos.global_position
	get_parent().add_child(bullet)
