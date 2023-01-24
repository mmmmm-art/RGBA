extends RigidBody2D


export(float, 0, 255) var R = 255
export(float, 0, 255) var G = 255
export(float, 0, 255) var B = 255
var entered = false
var entered2 = false
var RT = false
var GT = false
var BT = false
var AT = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.color = Color8(R,G,B)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	
	if RT and GT and BT and AT and entered or entered2:
		set_mode(RigidBody2D.MODE_RIGID)
	else:
		set_mode(RigidBody2D.MODE_STATIC)



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		entered = true
	if body.name != "Player" and body.name != "TileMap" and !body.is_in_group("Block"):
		if body.R == R and body.G == G and body.B == B:
			entered2 = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		entered = false
	if body.name != "Player" and body.name != "TileMap" and !body.is_in_group("Block"):
		entered2 = false
	
