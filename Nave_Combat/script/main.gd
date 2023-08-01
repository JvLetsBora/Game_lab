extends Control

const EVENT_LIFE = 20
const COIN_CONTROLADOR_INITIAL = 7

var eventLife = EVENT_LIFE
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
var tiro_t = 0
var _e = false
var _d = false
var btn = false

signal coin_anime
var _coinx = 0

var bg_eventos = [
	preload("res://prefebs/objetos_bg/satelite_obitando.tscn")
]

var evento = {
	0: "01",
	1: "02"
}

var coinFormacao = ""
var gerarFormacao = {
	0: "linha",
	1: "quina",
	2: "cobraX",
	3: "cobraY"
}
var coin_controlador = COIN_CONTROLADOR_INITIAL
var coinQuantia = 0
var coinX = 130
var coinY = 0
var ajusteBtn = 360

func _ready():
	init_game()
	init_player()

func _process(delta):
	if Global.Jogo_on:
		update_game(delta)
	else:
		update_game_over(delta)

func init_game():
	$AudioMain.volume_db = -60
	Global.Jogo_on = true
	$HUD/VoltarMenu.position.x = (get_viewport().size.x / 2) - ($HUD/VoltarMenu.normal.get_width() / 2)
	$HUD/Reiniciar.position.x = (get_viewport().size.x / 2) - ($HUD/VoltarMenu.normal.get_width() / 2)
	$HUD/VoltarMenu.position.y = (get_viewport().size.y / 100) * 20
	$HUD/Reiniciar.position.y = (get_viewport().size.y / 100) * 80
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	coinFormacao = gerarFormacao[rng.randi_range(1, gerarFormacao.size() - 1)]
	$HUD/score.visible = false
	$Nave.visible = true
	$HUD/Reiniciar.visible = false
	$HUD/VoltarMenu.visible = false
	$TimerParede.start()
	$TimerMeteoro.start()
	$Nave.position = Vector2((get_viewport().size.x) / 2, (get_viewport().size.x / 100) * 120)

func init_player():
	Global.nave.Pos = $Nave.position
	Global.nave.Coeficiente = $Nave.coeficiente
	$HUD/km.text = str(Global.nave.Coeficiente) + " K/s"
	kmPercorrido += 1100

func update_game(delta):
	update_audio()
	update_timer(delta)
	update_background(delta)
	update_coins(delta)
	update_events()
	update_input()
	update_shooting(delta)

func update_game_over(delta):
	if $AudioMain.volume_db != -80:
		$AudioMain.volume_db -= 2

	if $HUD/Tempo.rect_position.y < (get_viewport().size.y / 2) - 60:
		$HUD/Tempo.rect_position.y += 5 * (1 + delta)

	if $Nave.frame >= 8:
		$Nave.visible = false
		$HUD/Reiniciar.visible = true
		$HUD/VoltarMenu.visible = true
		$HUD/score.visible = true
		$HUD/score.text = str(kmPercorrido) + " Km"

	$TimerMeteoro.stop()
	$TimerParede.stop()

func update_audio():
	if $AudioMain.volume_db <= -20:
		$AudioMain.volume_db += 2

func update_timer(delta):
	a += delta
	timerEvent += delta
	timerEvent2 += delta
	$HUD/Tempo.text = str(int(timer)) + " Day"

	if a >= 2:
		a = 0
		timer += 1

func update_background(delta):
	$ParallaxBackground/primeiro.motion_offset.y += (($Nave.coeficiente + 1) * (150 * delta)) * 0.1
	$ParallaxBackground/quarto.motion_offset.y += (($Nave.coeficiente + 1) * (150 * delta)) * 0.4
	$ParallaxBackground/segundo.motion_offset.y += (($Nave.coeficiente + 1) * (150 * delta)) * 2

func update_coins(delta):
	coinQuantia = delta

	if timerEvent2 >= 6.8 and timerEvent2 <= coin_controlador:
		coinFormation(delta)

	if coin_controlador <= (COIN_CONTROLADOR_INITIAL - coinQuantia):
		timerEvent2 = 0
		coinY = 0
		coinX = 0
		coin_controlador = COIN_CONTROLADOR_INITIAL

func coinFormation(delta):
	if coinFormacao == "linha":
		coinX = 400
		coinY -= 27
		gera_Coin([coinX, coinY])
	elif coinFormacao == "quina":
		coinX -= 27
		gera_Coin([coinX + 360, coinY])
	elif coinFormacao == "cobraX":
		coinX -= 2
		coinY += ((coinY ^ 2) - coinY) * 21
		gera_Coin([coinX, coinY])
	elif coinFormacao == "cobraY":
		coinY -= 27
		coinX += ((coinY ^ 2) - coinY) * 21
		gera_Coin([coinX, coinY])

	coin_controlador -= delta / 100

func update_events():
	if timerEvent > eventLife:
		timerEvent = 0
		if fase == evento[0]:
			fase = evento[1]
		else:
			fase = evento[0]
	game_events()

func game_events():
	if fase == "01":
		Parede_on = false
		chuvaMeteoro_on = true
	elif fase == "02":
		chuvaMeteoro_on = false
		Parede_on = true

func update_input():
	if Input.is_action_pressed("ui_right") or _d:
		$Nave.direcaoD = 1
	if Input.is_action_pressed("ui_left") or _e:
		$Nave.direcaoE = -1

func update_shooting(delta):
	if atirando and tiro_t > 0.1:
		$Nave.emit_signal("tiro")
		tiro_t = 0
	tiro_t += delta

func _on_TimerMeteoro_timeout():
	if chuvaMeteoro_on and Global.Jogo_on:
		var meteoros1 = Meteoro.instance()
		var meteoros2 = Meteoro.instance()
		meteoros2.position.x = meteoros2.position.x - meteoros1.position.x
		meteoros2.tamanho = 0.5
		add_child(meteoros1)
		add_child(meteoros2)

func _on_TimerParede_timeout():
	if Parede_on and Global.Jogo_on:
		var Paredes = Parede.instance()
		add_child(Paredes)

func _on_Reiniciar_pressed():
	yield(get_tree().create_timer(0.2), "timeout")
	Global.Jogo_on = true
	get_tree().change_scene("res://scenes/Main.tscn")

func _on_Nave_tiro():
	if Global.Jogo_on:
		yield(get_tree().create_timer(0.1), "timeout")
		var TiroVai = Tiro.instance()
		add_child(TiroVai)
		TiroVai.position = $Nave.position
		municao -= 1

func gera_Coin(cordenada):
	var coinOn = coin.instance()
	add_child(coinOn)
	coinOn.position = Vector2(cordenada[0], cordenada[1])

func _on_VoltarMenu_pressed():
	get_tree().change_scene("res://scenes/Inicio.tscn")

func _on_HUD_gui_input(event):
	if event is InputEventScreenTouch:
		$Nave.tempo = 0
		if btn == false:
			_e = true
			_d = false
			btn = true
		else:
			_e = false
			_d = true
			btn = false

func _on_Control_coin_anime():
	_coinx += 1
	$HUD/Coins_tex.text = str(_coinx)

