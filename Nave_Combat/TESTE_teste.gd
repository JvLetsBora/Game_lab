extends Node
var Meteoro = preload("res://prefebs/Meteoro.tscn")



func _on_Button_button_down():
	var testura:Texture = preload("res://grafica/lock.png")
	var shader = preload("res://new_shader.tres")
	$TextureRect3.material = ShaderMaterial.new()
	$TextureRect3.material.shader = shader
	$TextureRect3.material.set_shader_param("locked_icon",testura)
	

	var meteoros1 = Meteoro.instance()
	var meteoros2 = Meteoro.instance()
	#meteoros.velocidade += ($Nave.coeficiente*Global.vel)
	meteoros2.position.x = meteoros2.position.x - meteoros1.position.x
	meteoros2.tamanho = 0.5
	add_child(meteoros1)
	add_child(meteoros2)


func _on_Button2_pressed():
	$TextureRect3.material = null
