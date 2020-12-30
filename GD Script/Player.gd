extends Area2D


onready var plBullet = preload("res://Bullet.tscn")
onready var f_position : Node2D = $Fpositions
onready var timer = $Timer


export var delayTimer = 0.3
export var speed : int = 200
var velocity : Vector2 = Vector2(0,0)


var s_life = 100
func _process(delta):
	pass
func _physics_process(delta):
	var dvelocity = Vector2(0,0)
	
	# For movements
	if Input.is_action_pressed("move_left"):
		dvelocity.x = -1
	elif Input.is_action_pressed("move_right"):
		dvelocity.x = 1
	if Input.is_action_pressed("move_up"):
		dvelocity.y = -1
	elif Input.is_action_pressed("move_down"):
		dvelocity.y = 1
	
	
	velocity = dvelocity.normalized() * speed
	position += velocity * delta
	
	## For attacking
	if Input.is_action_pressed("shoot") && timer.is_stopped():
		timer.start(delayTimer)
		for i in f_position.get_children():
			var Bullet = plBullet.instance()
			Bullet.global_position = i.global_position
			get_tree().current_scene.add_child(Bullet)
			$musicbullete.play()
			
	
	# For Bounds
	var s_size = get_viewport_rect().size
	if position.x > s_size.x:
		position.x = 0
	elif position.x<0:
		position.x = s_size.x
	position.y = clamp(position.y , 0 , s_size.y)
	
func d_ship(amount : int):
	s_life -= amount
	$ShootMusic.play()
	get_node("../Life").set_text("LIFE : " + str(s_life))
	if s_life <= 0 :
		queue_free()
		get_tree().change_scene("res://msg3.tscn")

func _on_Button_pressed():
	get_tree().change_scene("res://Main.tscn")


func _on_Player_area_entered(area):
	if area.is_in_group("black"):
		get_tree().change_scene("res://msg2.tscn")
		queue_free()
	
	if area.is_in_group("key"):
		get_tree().change_scene("res://msg4.tscn")
		queue_free()	
