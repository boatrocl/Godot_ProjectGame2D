extends CharacterBody2D

@export var speed = 150
@export var jump_force = -300
const GRAVITY = 980 
var screen_size 
var is_firing : bool

@export var max_hp : int = 5
var current_hp : int = max_hp
#signal item_collected(amount)
var bullet_path=preload("res://Scene/bullet.tscn")
func _ready():
	GameManager.set_player_hp(current_hp)
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	# look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot") and !is_firing and is_on_floor():
		fire()
	var horizontal_input = 0
	if Input.is_action_pressed("right"):
		horizontal_input += 1
	if Input.is_action_pressed("left"):
		horizontal_input -= 1
	
	velocity.x = horizontal_input * speed
	
	#jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	move_and_slide()
	
	#screen size
	position = position.clamp(Vector2.ZERO, screen_size)
	
	#animation
	if is_on_floor() and current_hp > 0:
		if abs(velocity.x) > 0:
			if is_firing == false:
				$AnimatedSprite2D.animation = "run"
				$AnimatedSprite2D.play()
			else:
				$AnimatedSprite2D.play("run_attack")
		else:
			if is_firing == false:
				$AnimatedSprite2D.animation = "idle"
				$AnimatedSprite2D.play()
			else:
				$AnimatedSprite2D.play("attack")
	elif current_hp > 0:
		$AnimatedSprite2D.animation = "jump"
		$AnimatedSprite2D.play()
	
	
	#flip Sprite h
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		$FiringPos.position.x = 16.0
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		$FiringPos.position.x = -16.0

func fire():
	is_firing = true
	$AttackTimer.start()
	var bullet = bullet_path.instantiate()
	bullet.add_to_group("player_bullet")
	if $AnimatedSprite2D.flip_h == false:
		bullet.rota = deg_to_rad(0)
	elif $AnimatedSprite2D.flip_h == true:
		bullet.rota = deg_to_rad(180)
	bullet.pos = $FiringPos.global_position
	get_parent().add_child(bullet)
	$ShootSound.play()

func _on_attack_timer_timeout() -> void:
	is_firing = false


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("traps"):
		current_hp -= 1
		GameManager.set_player_hp(current_hp)
		print("current hp " + str(current_hp))
	
	if current_hp <= 0:
		dead()

func dead():
	$AnimatedSprite2D.play("die")
	await get_tree().create_timer(1.0).timeout
	GameManager.set_player_hp(max_hp)
	get_tree().call_deferred("change_scene_to_file", "res://Scene/game_over.tscn")
	print("dead")
