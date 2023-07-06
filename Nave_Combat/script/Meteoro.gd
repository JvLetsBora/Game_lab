extends Area2D


# Declare member variables here. Examples:
export var velocidade = 130
export var tamanho = 1
const varia_MAX = 1.50
const varia_Min = 0.5
var rng = RandomNumberGenerator.new()
var posicaoInicial = 68
var impacto = false
var roda = 0
var meteoroVida = 10
var filho = false
var zig = true
var vida
onready var vida_ = [
	load("res://grafica/Eventos/CometaExplode/cometa_dan01.png"),
	load("res://grafica/Eventos/CometaExplode/cometa_dan02.png")
]


func _ready():
	Global.scaleMeteoro = get_children()[0].texture.get_size()
	if filho != true:
		self.position.y = -160
		rng.randomize()
		var my_random_number = rng.randf_range(1, 4)
		var my_random_number1 = rng.randf_range(varia_Min, varia_MAX)
		velocidade = velocidade*my_random_number
		tamanho = tamanho*my_random_number1
		scale.x = tamanho
		scale.y = tamanho
		my_random_number = rng.randf_range(0,478)
		position.x = posicaoInicial + my_random_number
		my_random_number = rng.randf_range(-1,1)
		roda = my_random_number1*my_random_number
	else:
		$Timer.start()
	Global.velMeteoro = velocidade
	if(tamanho < 1):
		meteoroVida = 6
		vida = meteoroVida
	else:
		meteoroVida = 4
		vida = meteoroVida

func _process(delta):
	if(position.y > get_viewport().size.y + 220 or position.x > get_viewport().size.x + 220 or position.x < -220):
		queue_free()
	elif(meteoroVida <= 0): #scale.x < 0.4
		var explode = load("res://prefebs/explode.tscn")
		var EXPLODE = explode.instance()
		EXPLODE.position = position
		EXPLODE.scale = scale
		get_parent().add_child(EXPLODE)
		if (scale.x > 0.5):
			if (tamanho > 1.3):
				for i in range(3):
					new_detrito(i,delta)
					
			else:
				new_detrito(0,delta)
		queue_free()
	if(Global.Jogo_on == true):
		if(impacto == true):
			if(tamanho > 1):
				position.y += (velocidade*delta)*(1+Global.nave.Coeficiente)
				position.x -= (velocidade + 2)*delta
				rotation_degrees += (roda + 110)*delta
			else:
				position.x += velocidade*delta
				position.y += ((velocidade + 2)*delta)*(1+Global.nave.Coeficiente)
				rotation_degrees += (roda + 80)*delta
		else:
			position.y += (velocidade*delta)*(1+Global.nave.Coeficiente)
			rotation_degrees += (roda+50)*delta
	if (meteoroVida*100)/vida <= 90 and (meteoroVida*100)/vida >= 75:
		$Cometa.texture = vida_[0]

	elif (meteoroVida*100)/vida <= 50:
		$Cometa.texture = vida_[1]



func _on_Area2D_area_entered(area):
	if(area.name == "Nave"):
		Global.Jogo_on = false
		$Cometa.texture = vida_[0]
	elif(area.is_in_group("tiroSimples")):
		meteoroVida -=1
	elif(area.is_in_group("Meteoro")):
		impacto = true
		meteoroVida -= 2
	elif(area.is_in_group("coletavel")):
		area.position += Vector2(1,1)
		
	else:
		meteoroVida -= meteoroVida


	


func new_detrito(i,delta):
	var detrito = load("res://prefebs/Meteoro.tscn")
	var DETRITO = detrito.instance()
	DETRITO.scale = Vector2((tamanho*0.3),(tamanho*0.3)) 
	DETRITO.roda = (roda*-1)*delta
	DETRITO.impacto = true
	if(zig==true):
		DETRITO.velocidade = 130 + i
		zig = false
	else:
		DETRITO.velocidade = -180 - i
		zig = true
	DETRITO.filho = true
	DETRITO.position = self.position + Vector2(i*30,i*20)
	get_parent().add_child(DETRITO)


func _on_Timer_timeout():
	filho = false
