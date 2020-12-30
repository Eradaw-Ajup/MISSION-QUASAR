extends Area2D

var speed : int = 500

func _physics_process(delta):
	position.y -= speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(area):
	if area.is_in_group("meteorite"):
		area.destruction(1)
		queue_free()
	if area.is_in_group("aliens"):
		area.destruct(10)
		queue_free()
	if area.is_in_group("black"):
		queue_free()
	
