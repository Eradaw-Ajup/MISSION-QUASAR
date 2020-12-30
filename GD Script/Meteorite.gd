extends Area2D


var life = 5
var speed = rand_range(100,200)
onready var splash = get_node("Splash")

onready var music = get_node("../ShootMusic")


func _ready():
	randomize()
	pass # Replace with function body.
func _physics_process(delta):
	position.y += speed * delta 
	
	
	var s_size = get_viewport_rect().size
	if position.x > s_size.x:
		position.x = 0
	elif position.x<0:
		position.x = s_size.x
	if position.y > s_size.y:
		position.y = 0
	elif position.y<0:
		position.y = s_size.y	
	
	
func destruction(amount : int):
	life -= amount
	get_node("../Score").score += 10
	splash.global_position = global_position
	splash.set_emitting(true)
	$ShootMusic.play()
	if life == 0:
		queue_free()
		get_node("../Score").score += 100
	get_node("../Score").set_text("SCORE : " + str(get_node("../Score").score))

	
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Meteorite_area_entered(area):
	if area.is_in_group("player") :
		area.d_ship(20)
		queue_free()
		
	if area.is_in_group("black") :
		queue_free()

