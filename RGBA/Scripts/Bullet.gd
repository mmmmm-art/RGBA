extends Area2D

export(PackedScene) var E: PackedScene = null
const RIGHT = Vector2.RIGHT
export(int) var SPEED: int = 300
var R = 255
var G = 255
var B = 255
var RT = false
var GT = false
var BT = false


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
	
	$Sprite.self_modulate = Color8(R,G,B)
	var movement = RIGHT.rotated(rotation) * SPEED * delta
	global_position += movement

func destroy():
	var e = E.instance()
	get_tree().current_scene.add_child(e)
	e.global_position = global_position
	e.self_modulate = Color8(R,G,B)
	
	queue_free()
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	print()
	if body.name == "TileMap":
		pass
	if body.name != "Player":
		destroy()
	if body.name == "Player":
		if !RT or !GT or !BT:
			UI.kill();
			Global.dead = true
			destroy()
		else: destroy()

