extends CharacterBody2D

@export var speed = 150
var screen_size 
signal item_collected(amount)

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	#if Input.is_action_pressed("move_down"):
		#velocity.y += 1
	#if Input.is_action_pressed("move_up"):
		#velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = true
	#elif velocity.y < 0:
		#$AnimatedSprite2D.animation = "up"
	#elif velocity.y > 0:
		#$AnimatedSprite2D.animation = "down"
		
