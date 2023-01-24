extends StaticBody2D

export(float, 0, 255) var R = 255
export(float, 0, 255) var G = 255
export(float, 0, 255) var B = 255
var entered = false 
var RT = false
var GT = false
var BT = false
var AT = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.color = Color8(R,G,B)


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
	
	if RT and GT and BT and AT or entered == true:
		self.add_collision_exception_with(Player)
	else:
		self.remove_collision_exception_with(Player)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		entered = true
	


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		entered = false


func _on_Area2D2_body_entered(body):
	if body.name == "Player" or body.name == "TileMap" or body.is_in_group("Plain"):
		return
	elif body.R == R and body.G == G and body.B == B:
		self.add_collision_exception_with(body)


func _on_Area2D2_body_exited(body):
	if body.name == "Player" or body.name == "TileMap":
		return
	
	self.remove_collision_exception_with(body)
