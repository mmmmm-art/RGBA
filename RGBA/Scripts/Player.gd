extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _process(delta):
	if !Global.dead:
		$ColorRect.color = Color8(Global.Red, Global.Green, Global.Blue, Global.Alpha)
		get_input()
		velocity = move_and_slide(velocity)
