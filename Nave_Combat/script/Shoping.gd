extends Control

var naves = []
var newView = false
export var padding = 50

var emFoco: String = ""
var a:float = 0.0



func _ready():
	newView = false
	_loadNavs("res://grafica/Shopping/navs/")
	if !naves.empty():
		_insertNavs(naves)
		_ordenar()
	a = 0.0
	modulate = Color(0, 0, 0)

func _process(delta):
	$SeuGanho.text = "R$ " + str(Global.dinheiro) + ",00"
	if (0.9 <= a and a <= 1.0):
		modulate = Color(1, 1, 1)
		a = 2.0
	elif a < 1: 
		modulate += Color(0.1, 0.1, 0.1, 0.01)
		a += 0.1
		
	for nave in $GDNaves.get_children():
		if _isCardSelected(nave):
			if nave.rect_scale.x < 1.2:
				nave.rect_scale += Vector2(0.05, 0.05)
				nave.modulate = Color(1, 1, 1)
			
			$GDNaves.move_child(nave, $GDNaves.get_child_count() - 1)
			emFoco = nave.name
		else:
			nave.modulate = Color(0.588235, 0.588235, 0.588235)
			if nave.rect_scale.x >= 1:
				nave.rect_scale -= Vector2(0.05, 0.05)
	
	if !newView:
		if "nav_" + Global.Nav_select[Global.id] != emFoco:
			for nave in $GDNaves.get_children():
				nave.rect_position.x -= 45
		else:
			newView = true
	
	if !emFoco.empty():
		var get_name = emFoco.get_slice("nav_", 1)
		$PowerGun.text = str(Global.allNavs[get_name].poder)
		$LiveMax.text = str(Global.allNavs[get_name].vida)
		$NavSkipp.text = str(Global.allNavs[get_name].Coeficiente)

func _input(event):
	if event is InputEventScreenDrag:
		var y_Limite_menor = $GDNaves.rect_size.y * 1.48
		var y_Limite_maior = $GDNaves.rect_size.y * 0.48
		if y_Limite_maior < event.position.y and event.position.y < y_Limite_menor:
			for nave in $GDNaves.get_children():
				nave.rect_position.x += event.relative.x

var index = 0

func _insertNavs(navsToInsert):
	$debug.text = str(navsToInsert)
	# nav.png.import
	for i in navsToInsert: 
		var new_name = "nav_" + i.get_slice(".", 0)
		var navTextureRect = TextureRect.new()
		var pathNav = "res://grafica/Shopping/navs/" + (i.get_slice(".", 0)+"."+i.get_slice(".", 1))
		print(pathNav)
		var navTexture: Texture = load(pathNav)
		navTextureRect.name = new_name
		navTextureRect.expand = false
		navTextureRect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		navTextureRect.texture = navTexture
		navTextureRect.anchor_bottom = 0.817
		navTextureRect.anchor_left = 0.285
		navTextureRect.anchor_top = 0.192
		navTextureRect.anchor_right = 0.718
		navTextureRect.rect_pivot_offset.x = 156
		navTextureRect.rect_pivot_offset.y = 186
		navTextureRect.rect_position.x += 120*index
		index +=1
		$GDNaves.add_child(navTextureRect)

func _loadNavs(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if !dir.current_is_dir():
				var name = String(fileName)
				if name.find("import") != -1 and name != ".DS_Store":
					naves.append(name)
			fileName = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func _isCardSelected(card):
	var xLimitMin = _calculatePosition(card, "-", padding, "x") + card.rect_position.x
	var xLimitMax = card.rect_position.x + _calculatePosition(card, "+", padding, "x")
	
	return 256 <= xLimitMin and xLimitMax <= 550

func _calculatePosition(obj, opera, k, axis):
	var diferencaPs = 0
	
	if axis == "x":
		if opera == "-":
			diferencaPs = obj.rect_position.x - obj.texture.get_size().x / 2 + k
		elif opera == "+":
			diferencaPs = obj.rect_position.x + obj.texture.get_size().x / 2 - k
	else: 
		if opera == "-":
			diferencaPs = obj.rect_position.y - obj.texture.get_size().y / 2
		elif opera == "+":
			diferencaPs = obj.rect_position.y + obj.texture.get_size().y / 2
	
	return diferencaPs

func _on_Buy_pressed():
	var get_name = emFoco.get_slice("nav_", 1)
	
	# Verifique se a nave não está na lista Global.Nav_select
	if not get_name in Global.Nav_select:
		# Adicione o nome da nave selecionada à lista Global.Nav_select
		Global.Nav_select.append(get_name)
	else:
		print("Esta nave já foi comprada.")
	# Imprima a lista atualizada
	for i in range(len(Global.Nav_select)) :
		if get_name == Global.Nav_select[i]:
			Global.id = i
	#print(Global.Nav_select)


func _ordenar():
	var ordem = $GDNaves.get_child_count()
	for nave in $GDNaves.get_children():
		$GDNaves.move_child(nave, ordem)
		ordem -= 1

func _on_Voltar_pressed():
	get_tree().change_scene("./scenes/Inicio.tscn")
