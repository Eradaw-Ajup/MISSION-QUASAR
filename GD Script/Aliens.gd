extends Area2D


onready var pleBullet = preload("res://E_bullet.tscn")
onready var f_position : Node2D = $f_pos
onready var timer = $Timer



export var delayTimer = 0.5
export var speed : int = 200
var velocity : Vector2 = Vector2(0,0)

export var dvelocity = Vector2(0,0)
var es_life = 100
func _process(delta):
	pass
func _physics_process(delta):
	
	
	velocity = dvelocity.normalized() * speed
	position += velocity * delta
	position.y - 80
	
	
	
	# For Bounds
	var s_size = get_viewport_rect().size
	if position.x >1100:
		position.x = 200
	elif position.x<150:
		position.x = 1000

	
func destruct(amount : int):
	es_life -= amount
	$Elife.set_text("LIFE : " + str(es_life))
	get_node("../Score").score +=10
	$ShootMusic.play()
	if es_life <= 0 :
		get_node("../Score").score +=100
		queue_free()
	get_node("../Score").set_text("SCORE : " + str(get_node("../Score").score))
	
	


func _on_Aliens_area_entered(area):
	if area.is_in_group("black"):
		queue_free()


func _on_Timer_timeout():
	var eBullet = pleBullet.instance()
	eBullet.global_position = f_position.global_position
	get_tree().current_scene.add_child(eBullet)
	$musicbullete.play()
