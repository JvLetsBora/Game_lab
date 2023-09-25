extends Node
var Meteoro = preload("res://prefebs/Meteoro.tscn")



func _on_Button_button_down():
	var meteoros1 = Meteoro.instance()
	var meteoros2 = Meteoro.instance()
	#meteoros.velocidade += ($Nave.coeficiente*Global.vel)
	meteoros2.position.x = meteoros2.position.x - meteoros1.position.x
	meteoros2.tamanho = 0.5
	add_child(meteoros1)
	add_child(meteoros2)
