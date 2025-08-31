extends Area2D

func _ready() -> void:
	# เริ่มเล่นอนิเมชั่นทันทีเมื่อโหนดพร้อม
	$AnimatedSprite2D.play("default")
