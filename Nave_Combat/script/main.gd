extends Control


#var nav_posicoes = []

var eventLife = 20
var timer = 0
var timerEvent = 0
var timerEvent2 = 0
var coin = preload("res://prefebs/Coin.tscn")
var Tiro = preload("res://prefebs/Tiro_c.tscn")
var Meteoro = preload("res://prefebs/Meteoro.tscn")
var Parede = preload("res://prefebs/Paredes.tscn")

var chuvaMeteoro_on = false
var Parede_on = false
var fase = "01"
var municao = 10
var a = 0
var kmPercorrido = 0
var btn = false

var atirando = false
var tiro_t =0
var _e = false
var _d = false
var target = null
var direita = false
var esquerda = false

signal coin_anime
var _coinx = 0

var bg_eventos = [
	preload("res://prefebs/objetos_bg/satelite_obitando.tscn")
]

var evento = {
	0:"01",
	1:"02"
}

var coinFormacao = ""
var gerarFormacao = {
	0: "linha",
	1: "quina",
	2: "cobraX",
	3: "cobraY"
	}
var coin_controlador = 7
var coinQuantia = 0
var coinX = 130
var coinY = 0
var ajusteBtn = 360

func _ready():
	gerarMeteoro()
	$AudioMain.volume_db = -60
	Global.Jogo_on = true
	$HUD/VoltarMenu.position.x = (get_viewport().size.x/2) - ($HUD/VoltarMenu.normal.get_width()/2)
	$HUD/Reiniciar.position.x = (get_viewport().size.x/2) - ($HUD/VoltarMenu.normal.get_width()/2)
	$HUD/VoltarMenu.position.y = (get_viewport().size.y/100)*20
	$HUD/Reiniciar.position.y = (get_viewport().size.y/100)*80
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	coinFormacao = gerarFormacao[rng.randi_range(1, gerarFormacao.size()-1)]
	$HUD/score.visible = false
	$Nave.visible = true
	$HUD/Reiniciar.visible = false
	$HUD/VoltarMenu.visible = false
	$TimerParede.start()
	$TimerMeteoro.start()
	$Nave.position = Vector2((get_viewport().size.x)/2,(get_viewport().size.x/100)*120)



func _process(delta):
	#print($Nave.direcao)
	
	if(Global.Jogo_on == true):
		if atirando == true and tiro_t > 0.1:
			$Nave.emit_signal("tiro")
			tiro_t = 0
		tiro_t += delta
		if $AudioMain.volume_db <= -20:
			$AudioMain.volume_db +=2
		a += delta
		Global.nave.Pos = $Nave.position
		Global.nave.Coeficiente = $Nave.coeficiente
		if target:
			if $Nave.position.x - 20 > target.x: 
				_e = true
				_d = false
			elif $Nave.position.x + 20 < target.x:
				_e = false
				_d = true
			elif $Nave.position.x +20 > target.x and $Nave.position.x -20 < target.x:
				_e = true
				_d = true


		$HUD/km.text = str(Global.nave.Coeficiente)+" K/s"
		kmPercorrido += 1100
		if (a >=2):
			a = 0
			timer += 1
			
		timerEvent += delta
		timerEvent2 += delta
		$HUD/Tempo.text = str(int(timer))+" Day"
		$ParallaxBackground/primeiro.motion_offset.y += (($Nave.coeficiente+1)*(150*delta))*0.1
		$ParallaxBackground/quarto.motion_offset.y += (($Nave.coeficiente+1)*(150*delta))*0.4
		$ParallaxBackground/segundo.motion_offset.y += (($Nave.coeficiente+1)*(150*delta))*2
		coinQuantia = delta
		if(timerEvent2 >= 6.8 and timerEvent2 <= coin_controlador):
				if(coinFormacao == "linha"):
					coinX = 400
					coinY -= 27
					gera_Coin([coinX,coinY])
				elif(coinFormacao == "quina"):
					coinX -= 27
					gera_Coin([coinX+360,coinY])
				elif(coinFormacao == "cobraX"):
					coinX -= 2
					coinY += ((coinY^2)-coinY)*21
					gera_Coin([coinX,coinY])
				elif(coinFormacao == "cobraY"):
					coinY -= 27
					coinX += ((coinY^2)-coinY)*21
					gera_Coin([coinX,coinY])
				coin_controlador -= delta/100
				
		if (coin_controlador <= (7 - coinQuantia)):
				timerEvent2 = 0
				coinY = 0
				coinX = 0
				coin_controlador = 7
		
		if(timerEvent > eventLife):
				timerEvent = 0
				if(fase == evento[0]):
					fase = evento[1]
				else:
					fase = evento[0]
		game_events()

		if(Input.is_action_pressed("ui_right") or _d == true):
			$Nave.direcaoD = 1



			
		if(Input.is_action_pressed("ui_left") or _e == true):
			$Nave.direcaoE = -1
			



		if(Input.is_action_just_pressed("ui_up")):
			atirando = true
		if ($Nave.direcao == 0):
			_e = false
			_d = false
	else:
		if $AudioMain.volume_db != -80:
			$AudioMain.volume_db -= 2
		
		if $HUD/Tempo.rect_position.y < (get_viewport().size.y/2)-60:
			$HUD/Tempo.rect_position.y += 5*(1+delta)
		if $Nave.frame >= $Nave.anima_fim:
			$Nave.visible = false
			$HUD/Reiniciar.visible = true
			$HUD/VoltarMenu.visible = true
			$HUD/score.visible = true
			$HUD/score.text = str(kmPercorrido) + " Km"
		$TimerMeteoro.stop()
		$TimerParede.stop()
#	update()


func game_events():
		if(fase == "01"):
			Parede_on = false
			chuvaMeteoro_on = true
			
			
		elif(fase == "02"):
			chuvaMeteoro_on = false
			Parede_on = true
	



func _on_TimerMeteoro_timeout():
	gerarMeteoro()


func _on_TimerParede_timeout():
	
	if(Parede_on == true ):
		var Paredes = Parede.instance()
		#Paredes.velocidade  += ($Nave.coeficiente*Global.vel)
		add_child(Paredes)






func _on_Reiniciar_pressed():
	#yield(get_tree().create_timer(0.2),"timeout")
	Global.Jogo_on = true
	get_tree().change_scene("res://scenes/Main.tscn")
	



func _on_Nave_tiro():
	if(Global.Jogo_on == true):
		yield(get_tree().create_timer(0.1),"timeout")
		var TiroVai = Tiro.instance()
		add_child(TiroVai)
		TiroVai.position = $Nave.position
		municao -= 1


func gera_Coin(cordenada):
	var coinOn = coin.instance()
	add_child(coinOn)
	coinOn.position = Vector2(cordenada[0],cordenada[1])

	




func _on_VoltarMenu_pressed():
	get_tree().change_scene("res://scenes/Inicio.tscn") 


func _on_HUD_gui_input(event):
	#$debug.text = str(event)
	if (event is InputEventScreenDrag or event is InputEventScreenTouch):
		#print(event.position)
		#$debug.text = str(event.index)
		#if event.position.x > get_viewport().size.x/2:
		#	_e = false
		#	_d = true
		#elif event.position.x < get_viewport().size.x/2:
		#	_d = false
		#	_e = true
		
		# Seguindo o ponteiro do mouse:
		#if event.position.x > $Nave.position.x:
		target = event.position
#		if event.relative.x > 0:
#			_e = false
#			_d = true
#		elif event.relative.x < 0:
#			_d = false
#			_e = true

	#elif (event is InputEventScreenTouch):
	#	if event.position.x > get_viewport().size.x/2:
	#		_e = false
	#		_d = true
	#	elif event.position.x < get_viewport().size.x/2:
	#		_d = false
	#		_e = true
		
	#if (event is InputEventScreenTouch):
		#if (event.pressed == true):
			#nav_posicoes.append(Global.nave["Pos"])
			#update()
			#$Nave.tempo = 0
#			if (btn == false):
#				_e = true
#				_d = false
#				btn = true
#			elif(btn == true):
#				_e = false
#				_d = true
#				btn = false

func _on_Control_coin_anime():
	_coinx += 1
	$HUD/Coins_tex.text = str(_coinx)

#func ratangulo_area(pos):
#	var color = Color(1.0, 0.0, 0.0)
#	var size = Vector2(get_viewport().size.x-pos.x + 20,60)
#	pos.x = pos.x + 20
	
#	draw_rect(Rect2(pos,size), color, true, 1.0, false)
#	var size_2 = Vector2(get_viewport().size.x-pos.x - 20,60)
#	pos.x = 0
#	draw_rect(Rect2(pos,size_2), color, true, 1.0, false)

#func _draw():
#	ratangulo_area($Nave.position)



func gerarMeteoro():
	if(chuvaMeteoro_on == true):
		var meteoros1 = Meteoro.instance()
		var meteoros2 = Meteoro.instance()
		#meteoros.velocidade += ($Nave.coeficiente*Global.vel)
		meteoros2.position.x = meteoros2.position.x - meteoros1.position.x
		meteoros2.tamanho = 0.5
		add_child(meteoros1)
		add_child(meteoros2)
