extends Node2D

var TEXTURAS = {
	"Nav_Obsidian": {
		"idle":[load("res://grafica/NavsTexture/Obsidian/idle/Obsidian_IDLE_01.png"),load("res://grafica/NavsTexture/Obsidian/idle/Obsidian_IDLE_02.png"),load("res://grafica/NavsTexture/Obsidian/idle/Obsidian_IDLE_03.png"),load("res://grafica/NavsTexture/Obsidian/idle/Obsidian_IDLE_04.png")],
		"D":[load("res://grafica/NavsTexture/Obsidian/D/Obsidian_Lados_01.png"),load("res://grafica/NavsTexture/Obsidian/D/Obsidian_Lados_02.png"),load("res://grafica/NavsTexture/Obsidian/D/Obsidian_Lados_03.png"),load("res://grafica/NavsTexture/Obsidian/D/Obsidian_Lados_04.png")],
		"E":[load("res://grafica/NavsTexture/Obsidian/E/E_01.png"),load("res://grafica/NavsTexture/Obsidian/E/E_02.png"),load("res://grafica/NavsTexture/Obsidian/E/E_03.png"),load("res://grafica/NavsTexture/Obsidian/E/E_04.png")],
		"morta":[load("res://grafica/NavsTexture/Obsidian/morte/images/Obsidian_morte_01.png"),load("res://grafica/NavsTexture/Obsidian/morte/images/Obsidian_morte_02.png"),load("res://grafica/NavsTexture/Obsidian/morte/images/Obsidian_morte_03.png"),load("res://grafica/NavsTexture/Obsidian/morte/images/Obsidian_morte_04.png"),load("res://grafica/NavsTexture/Obsidian/morte/images/Obsidian_morte_05.png"),load("res://grafica/NavsTexture/Obsidian/morte/images/Obsidian_morte_06.png"),load("res://grafica/NavsTexture/Obsidian/morte/images/Obsidian_morte_07.png"),load("res://grafica/NavsTexture/Obsidian/morte/images/Obsidian_morte_08.png"),load("res://grafica/NavsTexture/Obsidian/morte/images/Obsidian_morte_09.png")]
	},
	"Nav_Normal": {
		"idle":[load("res://grafica/NavsTexture/Normal/nave0.png"),load("res://grafica/NavsTexture/Normal/nave-1.png"),load("res://grafica/NavsTexture/Normal/nave-2.png"),load("res://grafica/NavsTexture/Normal/nave.png")],
		"E":[load("res://grafica/NavsTexture/Normal/naveE0.png"),load("res://grafica/NavsTexture/Normal/naveE1.png"),load("res://grafica/NavsTexture/Normal/naveE2.png"),load("res://grafica/NavsTexture/Normal/naveE.png")],
		"D":[load("res://grafica/NavsTexture/Normal/naveD0.png"),load("res://grafica/NavsTexture/Normal/naveD1.png"),load("res://grafica/NavsTexture/Normal/naveD2.png"),load("res://grafica/NavsTexture/Normal/naveD3.png")],
		"morta":[load("res://grafica/NavsTexture/Normal/nav_morte1.png"),load("res://grafica/NavsTexture/Normal/nav_morte2.png"),load("res://grafica/NavsTexture/Normal/nav_morte3.png"),load("res://grafica/NavsTexture/Normal/nav_morte4.png"),load("res://grafica/NavsTexture/Normal/nav_morte5.png"),load("res://grafica/NavsTexture/Normal/nav_morte6.png"),load("res://grafica/NavsTexture/Normal/nav_morte7.png"),load("res://grafica/NavsTexture/Normal/nav_morte8.png"),load("res://grafica/NavsTexture/Normal/nav_morte9.png")]
	},
	"Nav_Spectra": {
		"idle":[load("res://grafica/NavsTexture/Spectra/IDLE/opressor_Idle_01.png"),load("res://grafica/NavsTexture/Spectra/IDLE/opressor_Idle_02.png"),load("res://grafica/NavsTexture/Spectra/IDLE/opressor_Idle_03.png"),load("res://grafica/NavsTexture/Spectra/IDLE/opressor_Idle_04.png")],
		"E":[load("res://grafica/NavsTexture/Spectra/E/E_0.png"),load("res://grafica/NavsTexture/Spectra/E/E_1.png"),load("res://grafica/NavsTexture/Spectra/E/E_2.png"),load("res://grafica/NavsTexture/Spectra/E/E_3.png")],
		"D":[load("res://grafica/NavsTexture/Spectra/D/D_0.png"),load("res://grafica/NavsTexture/Spectra/D/D_1.png"),load("res://grafica/NavsTexture/Spectra/D/D_2.png"),load("res://grafica/NavsTexture/Spectra/D/D_3.png")],
		"morta":[load("res://grafica/NavsTexture/Normal/nav_morte1.png"),load("res://grafica/NavsTexture/Normal/nav_morte2.png"),load("res://grafica/NavsTexture/Normal/nav_morte3.png"),load("res://grafica/NavsTexture/Normal/nav_morte4.png"),load("res://grafica/NavsTexture/Normal/nav_morte5.png"),load("res://grafica/NavsTexture/Normal/nav_morte6.png"),load("res://grafica/NavsTexture/Normal/nav_morte7.png"),load("res://grafica/NavsTexture/Normal/nav_morte8.png"),load("res://grafica/NavsTexture/Normal/nav_morte9.png")]
	}
}
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
#	print(limite_baixo)
	if Global.Nav_select == "Obsidian" :
		$AnimatedSprite.frames.clear("parada")
		$AnimatedSprite.frames.clear("andandoD")
		$AnimatedSprite.frames.clear("andandoE")
		$AnimatedSprite.frames.clear("morta")
		for i in range(4):
			$AnimatedSprite.frames.add_frame("parada",TEXTURAS.Nav_Obsidian.idle[i],i)
			$AnimatedSprite.frames.add_frame("andandoD",TEXTURAS.Nav_Obsidian.D[i],i)
			$AnimatedSprite.frames.add_frame("andandoE",TEXTURAS.Nav_Obsidian.E[i],i)
		for i in range(9):
			$AnimatedSprite.frames.add_frame("morta",TEXTURAS.Nav_Obsidian.morta[i],i)
		esquiva = 1.25
		vel_limite = 2.25
	elif Global.Nav_select == "Spectra" :
		$AnimatedSprite.frames.clear("parada")
		$AnimatedSprite.frames.clear("andandoD")
		$AnimatedSprite.frames.clear("andandoE")
		$AnimatedSprite.frames.clear("morta")
		for i in range(4):
			$AnimatedSprite.frames.add_frame("parada",TEXTURAS.Nav_Spectra.idle[i],i)
			$AnimatedSprite.frames.add_frame("andandoD",TEXTURAS.Nav_Spectra.D[i],i)
			$AnimatedSprite.frames.add_frame("andandoE",TEXTURAS.Nav_Spectra.E[i],i)
		for i in range(9):
			$AnimatedSprite.frames.add_frame("morta",TEXTURAS.Nav_Spectra.morta[i],i)
		esquiva = 1.15
		vel_limite = 1.5
	else:
		$AnimatedSprite.frames.clear("parada")
		$AnimatedSprite.frames.clear("andandoD")
		$AnimatedSprite.frames.clear("andandoE")
		$AnimatedSprite.frames.clear("morta")
		for i in range(4):
			$AnimatedSprite.frames.add_frame("parada",TEXTURAS.Nav_Normal.idle[i],i)
			$AnimatedSprite.frames.add_frame("andandoD",TEXTURAS.Nav_Normal.D[i],i)
			$AnimatedSprite.frames.add_frame("andandoE",TEXTURAS.Nav_Normal.E[i],i)
		for i in range(9):
			$AnimatedSprite.frames.add_frame("morta",TEXTURAS.Nav_Normal.morta[i],i)
		esquiva = 1
		vel_limite = 1.2
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
	var a = 6*(((p-get_viewport().size.x)*(p-(get_viewport().size.x/2)))/((0-get_viewport().size.x)*(0-(get_viewport().size.x/2))))+1*(((p+0)*(p-get_viewport().size.x))/((get_viewport().size.x/2)*((get_viewport().size.x/2)-get_viewport().size.x)))-6*((p*(p-(get_viewport().size.x/2)))/(get_viewport().size.x*(get_viewport().size.x-(get_viewport().size.x/2))))
	return a

func getVel(p):
	var vel =p
	return vel
