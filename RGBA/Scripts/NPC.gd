extends KinematicBody2D


export(float, 50, 200) var Speed = 150
export(float, 0, 255) var R = 255
export(float, 0, 255) var G = 255
export(float, 0, 255) var B = 255
var entered = false
var velocity: Vector2 = Vector2.ZERO
var path: Array = []
var levelNav: Navigation2D = null
var idle = true
var stop = false
export var radius = 400
export var text = ""


func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("Nav"):
		levelNav = tree.get_nodes_in_group("Nav")[0]
	$Area2D/CollisionShape2D.shape.radius = radius
	$ColorRect.color = Color8(R,G,B)
	$Label.self_modulate = Color8(R,G,B)
	$Label.text = text


func _physics_process(delta):
	if !Global.dead:
		idle = true
		$Line2D.global_position = Vector2.ZERO
		if levelNav:
			GeneratePath()
			Navigate()
		if global_position.distance_to($Wander.target_position) <= 5:
			$Wander.update_target()
		if entered == true:
			idle = false
			stop = true
		elif entered == false:
			idle = true
			stop = false
		move();

func Navigate():
	if !stop:
		if path.size() > 0:
				velocity = global_position.direction_to(path[1]) * Speed
				if global_position == path[0]:
					path.pop_front()


func GeneratePath():
	if levelNav != null:
		if !stop:
			if idle:
				path = levelNav.get_simple_path(global_position, $Wander.target_position, true)
				$Line2D.points = path


func move():
	if !stop:
		velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	
	entered = true
	$AnimationPlayer.play("Text")


func _on_Area2D_body_exited(body):
	if body.name != "Player":
		return
	
	entered = false
	$Label.visible = false
	$Label.percent_visible = 0
