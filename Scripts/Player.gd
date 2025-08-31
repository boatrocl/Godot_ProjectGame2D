extends CharacterBody2D

@export var speed = 150
@export var jump_force = -300
const GRAVITY = 980 
var screen_size 
#signal item_collected(amount)
var bullet_path=preload("res://Scene/bullet.tscn")
func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("ui_left"):
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
	if is_on_floor():
		if abs(velocity.x) > 0:
			$AnimatedSprite2D.animation = "run"
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.animation = "idle"
			$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.animation = "jump"
		$AnimatedSprite2D.play()
	
	#flip Sprite h
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir = rotation
	bullet.pos = $Node2D.global_position
	get_parent().add_child(bullet)
