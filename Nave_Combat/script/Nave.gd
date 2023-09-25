extends Node2D

#res://grafica/NavsTexture/

var anima_fim = 0
var TEXTURAS = [
	["res://grafica/NavsTexture/"+Global.Nav_select[Global.id]+"/D/","andandoD"],
	["res://grafica/NavsTexture/"+Global.Nav_select[Global.id]+"/E/","andandoE"],
	["res://grafica/NavsTexture/"+Global.Nav_select[Global.id]+"/morte/","morta"],
	["res://grafica/NavsTexture/"+Global.Nav_select[Global.id]+"/IDLE/","parada"]
	]
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
	coeficiente = Global.allNavs[Global.Nav_select[Global.id]]["Coeficiente"]
	vel_limite = coeficiente+1.2
	$AnimatedSprite.frames.clear("parada")
	$AnimatedSprite.frames.clear("andandoD")
	$AnimatedSprite.frames.clear("andandoE")
	$AnimatedSprite.frames.clear("morta")
	for path in TEXTURAS:
		dir_contents(path[0],path[1])
	$AnimatedSprite.animation = "parada"
	anima_fim = int($AnimatedSprite.frames.get_frame_count("morta"))-1
	

func _process(delta):
	
	frame = $AnimatedSprite.frame

	if(Global.Jogo_on == true):
		
		direcao = direcaoE+direcaoD
		if(direcao > 0 and position.x < limites_e):
			if(coeficiente > 0.8):
				coeficiente -= (coeficiente)*delta
				
			$AnimatedSprite.animation = "andandoD"
			$Motor_direito.flame_fail = true
			$Motor_direito2.flame_fail = true
			$Motor_direito3.on_engine = false
			$Motor_direito3.flame_fail = true
			position.x += (velocidade*delta*esquiva)*direcao

			rotation_degrees += tempo*delta
			if(position.y < limite_baixo):position.y += esquiva
		
		if(direcao < 0 and  position.x > limites_d):
			if(coeficiente > 1):
				coeficiente -= (coeficiente)*delta
				
			$AnimatedSprite.animation = "andandoE"
			$Motor_direito.flame_fail = true
			$Motor_direito2.on_engine = false
			$Motor_direito2.flame_fail = true
			$Motor_direito3.flame_fail = true

			
			position.x += (velocidade*delta*esquiva)*direcao
			rotation_degrees -= tempo*delta
			if(position.y < limite_baixo):position.y += esquiva
		
		if(direcao == 0 or position.x <= limites_d or position.x >= limites_e):
			rotation_degrees = 0
			if coeficiente < vel_limite or coeficiente < vel_limite*1.3 and position.y <= 330:
				coeficiente += delta
				
			direcaoE = 0
			direcaoD = 0
			$AnimatedSprite.animation = "parada"
			$Motor_direito.on_engine = true
			$Motor_direito2.on_engine = true
			$Motor_direito3.on_engine = true
			
			$Motor_direito.flame_fail = false
			$Motor_direito2.flame_fail = false
			$Motor_direito3.flame_fail = false
			

			
			if(position.y > 320):
				#print(position)
				#position.y -= 1+coeficiente
				pass
		else:
			rotation_degrees = getDegress(position.x)
	else:
		$AnimatedSprite.animation = "morta"



		
	

func getDegress(p):
	var a = 6-((4*p*(2*get_viewport().size.x+p))/(get_viewport().size.x*get_viewport().size.x))
	return a

func dir_contents(path,anima):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var i = 0
		while file_name != "":
			if !dir.current_is_dir():
				var _name = String(file_name)
				if _name.find("import") != -1 and _name != ".DS_Store":
					var _path:Texture = load(path+(_name.get_slice(".", 0)+"."+_name.get_slice(".", 1)))
					$AnimatedSprite.frames.add_frame(anima,_path,i)
					i += 1
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
