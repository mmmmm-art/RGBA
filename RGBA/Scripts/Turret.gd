extends Node2D

export(PackedScene) var BULLET: PackedScene = null
var R = round(rand_range(0,255))
var G = round(rand_range(0,255))
var B = round(rand_range(0,255))
export(float, 0, 255) var Alpha = 255
export(float, 0, 500) var rangee = 250
export(float, 0.1, 2) var reload = 1
var time = false
var AT = false



func _ready():
	yield(get_tree(), "idle_frame")
	$RayCast2D/Timer.wait_time = reload
	$RayCast2D.cast_to = Vector2(rangee, 0)
	$Gun.self_modulate = Color8(R,G,B)

func _physics_process(delta):
	if Global.Alpha < Alpha + Global.offset and Global.Alpha > Alpha - Global.offset:
		AT = true
	else: AT = false
	
	if !Global.dead:
		$Gun.self_modulate = Color8(R,G,B)
		var angle = global_position.direction_to(Player.global_position).angle()
		$RayCast2D.global_rotation = angle
		if $RayCast2D.is_colliding() and $RayCast2D.get_collider().is_in_group("Player"):
			$Sprite.rotation_degrees = $RayCast2D.global_rotation_degrees + 90
			if $RayCast2D/Timer.is_stopped():
				if !AT:
					shoot()
					R = round(rand_range(0,255))
					G = round(rand_range(0,255))
					B = round(rand_range(0,255))




func shoot():
	time = false
	
	if BULLET:
		var bullet = BULLET.instance()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		bullet.global_rotation = $RayCast2D.global_rotation
		bullet.R = R
		bullet.G = G
		bullet.B = B
		$RayCast2D/Timer.start()


func _on_Timer_timeout():
	time = true
