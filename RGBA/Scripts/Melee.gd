extends KinematicBody2D


var SPEED = 150
export var Speed = 150
export(float, 0, 255) var R = 255
export(float, 0, 255) var G = 255
export(float, 0, 255) var B = 255
var entered = false
var velocity: Vector2 = Vector2.ZERO
var path: Array = []
var levelNav: Navigation2D = null
var idle = true
var chase = false
export var radius = 400
var RT = false
var GT = false
var BT = false
var AT = false

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("Nav"):
		levelNav = tree.get_nodes_in_group("Nav")[0]
	$Area2D/CollisionShape2D.shape.radius = radius
	$ColorRect.color = Color8(R,G,B)

func _physics_process(delta):
	if Global.Red < R + Global.offset and Global.Red > R - Global.offset:
		RT = true
	else: RT = false
	if Global.Green < G + Global.offset and Global.Green > G - Global.offset:
		GT = true
	else: GT = false
	if Global.Blue < B + Global.offset and Global.Blue > B - Global.offset:
		BT = true
	else: BT = false
	if Global.Alpha < 255 + Global.offset and Global.Alpha > 255 - Global.offset:
		AT = true
	else: AT = false
	
	if !Global.dead:
		idle = true
		$Line2D.global_position = Vector2.ZERO
		if levelNav:
			GeneratePath()
			Navigate()
		if global_position.distance_to($Wander.target_position) <= 5:
			$Wander.update_target()
		if entered == true and (!RT or !GT or !BT or !AT):
			idle = false
			chase = true
		elif entered == false or (RT and GT and BT and AT):
			idle = true
			chase = false
		move();

func Navigate():
	if chase:
		SPEED = Speed + 50
	if idle:
		SPEED = Speed
	if path.size() > 0:
			velocity = global_position.direction_to(path[1]) * SPEED
		
			if global_position == path[0]:
				path.pop_front()
	

func GeneratePath():
	if levelNav != null:
		if chase:
			path = levelNav.get_simple_path(global_position, Player.position, true)
			$Line2D.points = path
		elif idle:
			path = levelNav.get_simple_path(global_position, $Wander.target_position, true)
			$Line2D.points = path

func move():
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	if body != Player:
		return
	entered = true


func _on_Area2D_body_exited(body):
	if body != Player:
		return
	entered = false


func _on_Area2D2_body_entered(body):
	if body.name != "Player":
		return
	UI.kill();
	Global.dead = true
