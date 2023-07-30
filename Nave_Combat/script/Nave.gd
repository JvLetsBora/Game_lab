extends Node2D

#res://grafica/NavsTexture/
var vel_limite = 1.2
export var velocidade = 600
export var esquiva = 1
export var coeficiente = 1
export var frame = 0
onready var limites_d = get_viewport().size[0]/15
onready var limites_e = get_viewport().size[0] - (get_viewport().size[0]/15)
onready var limite_baixo =  (get_viewport().size[1]/100)*70
var direcao = 0
export var direcaoD = 0
export var direcaoE = 0
signal tiro
export var tempo = 0

func _ready():
	$AnimatedSprite.animation = "parada"

func _process(delta):
	frame = $AnimatedSprite.frame

	if(Global.Jogo_on == true):
		
		direcao = direcaoE+direcaoD
		if(direcao > 0 and position.x < limites_e):
			if(coeficiente > 0.5):
				coeficiente -= (coeficiente)*delta
				
			$AnimatedSprite.animation = "andandoD"
			position.x += (velocidade*delta*esquiva)*direcao

			rotation_degrees += tempo*delta
			if(position.y < limite_baixo):position.y += esquiva
		
		if(direcao < 0 and  position.x > limites_d):
			if(coeficiente > 0.5):
				coeficiente -= (coeficiente)*delta
				
			$AnimatedSprite.animation = "andandoE"
			position.x += (velocidade*delta*esquiva)*direcao
			rotation_degrees -= tempo*delta
			if(position.y < limite_baixo):position.y += esquiva
		
		if(direcao == 0 or position.x <= limites_d or position.x >= limites_e):
			rotation_degrees = 0
			if coeficiente < vel_limite or coeficiente < vel_limite*1.3 and position.y <= 330:
				coeficiente += (delta/2)
				
			direcaoE = 0
			direcaoD = 0
			$AnimatedSprite.animation = "parada"
			if(position.y > 320):
				position.y -= 1+coeficiente
		else:
			rotation_degrees = getDegress(position.x)
	else:
		$AnimatedSprite.animation = "morta"
	

func getDegress(p):
	var a = 6-((4*p*(2*get_viewport().size.x+p))/(get_viewport().size.x*get_viewport().size.x))
	return a

func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				var _name = String(file_name)
				if _name.find("import") == -1 and _name != ".DS_Store":
					Global.naves_.append(_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func getVel(p):
	var vel =p
	return vel
