extends Control

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
var atirando = false
var tiro_t =0
var _e = false
var _d = false
var btn = false

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
var coinQuantia = 0.009
var coinX = 130
var coinY = 0


func _ready():
	$AudioMain.volume_db = -60
	Global.Jogo_on = true
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	coinFormacao = gerarFormacao[rng.randi_range(1, gerarFormacao.size()-1)]
	$HUD/score.visible = false
	$Nave.visible = true
	$HUD/Reiniciar.visible = false
	$HUD/VoltarMenu.visible = false
	$TimerParede.start()
	$TimerMeteoro.start()
	$Nave.position = Vector2(300,800)



func _process(delta):
	#print($Nave.direcao)
	if(Global.Jogo_on == true):
		#print(timer)
		if atirando == true and tiro_t > 0.1:
			$Nave.emit_signal("tiro")
			tiro_t = 0
		tiro_t += delta
		if $AudioMain.volume_db <= -20:
			$AudioMain.volume_db +=2
		a += delta
		Global.nave.Pos = $Nave.position
		Global.nave.Coeficiente = $Nave.coeficiente
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

		if(timerEvent2 >= 6.8 and timerEvent2 <= coin_controlador):
				if(coinFormacao == "linha"):
					coinX = 400
					coinY -= 27
					gera_Coin([coinX,coinY])
				elif(coinFormacao == "quina"):
					coinX -= 27
					gera_Coin([coinX+360,coinY])
				elif(coinFormacao == "cobraX"):
					coinX += 27
					coinY -= ((coinX^2)-coinX)*7
					gera_Coin([coinX,coinY])
				elif(coinFormacao == "cobraY"):
					coinY -= 27
					coinX += ((coinY^2)-coinY)*21
					gera_Coin([coinX,coinY])
				coin_controlador -= 0.001 
				
		if (coin_controlador <= (7 - coinQuantia)):
				timerEvent2 = 0
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
		
		if $HUD/Tempo.rect_position.y < 400:
			$HUD/Tempo.rect_position.y += 5*(1+delta)
		if $Nave.frame >= 8:
			$Nave.visible = false
			$HUD/Reiniciar.visible = true
			$HUD/VoltarMenu.visible = true
			$HUD/score.visible = true
			$HUD/score.text = str(kmPercorrido) + " Km"
		$TimerMeteoro.stop()
		$TimerParede.stop()



func game_events():
		if(fase == "01"):
			Parede_on = false
			chuvaMeteoro_on = true
			
			
		elif(fase == "02"):
			chuvaMeteoro_on = false
			Parede_on = true
	



func _on_TimerMeteoro_timeout():

	if(chuvaMeteoro_on == true and Global.Jogo_on == true):
		var meteoros = Meteoro.instance()
		#meteoros.velocidade += ($Nave.coeficiente*Global.vel)
		add_child(meteoros)


func _on_TimerParede_timeout():
	
	if(Parede_on == true and Global.Jogo_on == true):
		var Paredes = Parede.instance()
		#Paredes.velocidade  += ($Nave.coeficiente*Global.vel)
		add_child(Paredes)






func _on_Reiniciar_pressed():
	yield(get_tree().create_timer(0.2),"timeout")
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
#	if (event is InputEventScreenTouch):
#		if event.position.x > 400:
#			_d = true
#		if event.position.x < 400:
#			_e = true
	if (event is InputEventScreenTouch):
		if (event.pressed == true):
			if (btn == false):
				_e = true
				_d = false
				btn = true
			elif(btn == true):
				_e = false
				_d = true
				btn = false


func _on_Control_coin_anime():
	_coinx += 1
	$HUD/Coins_tex.text = str(_coinx)
