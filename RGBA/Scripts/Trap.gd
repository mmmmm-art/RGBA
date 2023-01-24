extends Area2D

export(float, 0, 255) var R = 255
export(float, 0, 255) var G = 255
export(float, 0, 255) var B = 255

func _ready():
	$ColorRect3.color = Color8(R,G,B)
	$ColorRect4.color = Color8(R,G,B)
	$ColorRect5.color = Color8(R,G,B)
	$ColorRect6.color = Color8(R,G,B)



func _on_Trap_body_entered(body):
	if body.name != "Player":
		return
	
	Global.Red = R
	Global.Green = G
	Global.Blue = B
