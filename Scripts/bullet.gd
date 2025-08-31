extends CharacterBody2D
var pos:Vector2
var rota:float
var dir:float
var speed = 100

func _ready():
	global_position=pos
	global_rotation=rota
func _physics_process(_delta):
	velocity = Vector2(speed,0).rotated(dir)
	$AnimatedSprite2D.animation = "shoot"
	$AnimatedSprite2D.play()
	move_and_slide()
	if position.x < 0 or position.x > get_viewport_rect().size.x or position.y < 0 or position.y > get_viewport_rect().size.y:
		queue_free()
func _on_area_2d_body_entered(body:Node2D):
	print(pos)
	if body.is_in_group("tilemap_colision"):
		queue_free()
