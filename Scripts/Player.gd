extends CharacterBody2D

@export var speed = 150
@export var jump_force = -300  # แรงกระโดด (ค่าลบเพราะแกน Y ลงเป็นบวก)
const GRAVITY = 980  # เพิ่ม Gravity ให้เหมาะสม
var screen_size 
signal item_collected(amount)

func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):  # เปลี่ยนเป็น _physics_process สำหรับการเคลื่อนไหว
	# Gravity ทำงานตลอดเวลา
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# การเคลื่อนที่แนวนอน
	var horizontal_input = 0
	if Input.is_action_pressed("right"):
		horizontal_input += 1
	if Input.is_action_pressed("left"):
		horizontal_input -= 1
	
	velocity.x = horizontal_input * speed
	
	# การกระโดด
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	# อัพเดทการเคลื่อนที่
	move_and_slide()
	
	# จำกัดขอบเขตหน้าจอ
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# การจัดการ animation
	if is_on_floor():
		if abs(velocity.x) > 0:
			$AnimatedSprite2D.animation = "run"
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.animation = "idle"  # ควรมี animation idle
			$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.animation = "jump"  # ควรมี animation jump
		$AnimatedSprite2D.play()
	
	# พลิก Sprite ตามทิศทาง
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
