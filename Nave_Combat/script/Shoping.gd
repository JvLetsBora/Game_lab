extends Control


var naves_ = []
var new_view = false

# Called when the node enters the scene tree for the first time.
func _ready():
	new_view = false
	self.dir_contents("res://grafica/Shopping/navs/")
	if !naves_.empty():
		self.insert_navs(naves_)
		self.ordenar()
	a = 0
	modulate = Color(0, 0, 0)

var Emfoco:String = ""
var a = 0
export var padding = 50


func _process(delta):
	$SeuGanho.text = "R$"+str(Global.dinheiro)+",00"
	if a >= 0.9 and a <=1:
		modulate = Color(1, 1, 1)
		a = 2
	elif a < 1: 
		modulate += Color(0.1, 0.1, 0.1,0.01)
		a += 0.1
		
	for nave in $GDNaves.get_children():
		#Carde selecionado, x:[220 a 492]
		if(operacao(nave,"-",padding,"x") + nave.rect_position.x  >= 256 and nave.rect_position.x + operacao(nave,"+",padding,"x") <= 550):
			if (nave.rect_scale.x < 1.2):
				nave.rect_scale += Vector2(0.05,0.05)
				nave.modulate = Color(1, 1, 1)
			
			$GDNaves.move_child(nave,($GDNaves.get_child_count()-1))
			#print(nave.get_index())
			Emfoco = nave.name
		#Demais cards
		else:
			nave.modulate = Color(0.588235, 0.588235, 0.588235)
			if (nave.rect_scale.x >= 1):nave.rect_scale -= Vector2(0.05,0.05)
	if (new_view == false):
		if(("nav_"+Global.Nav_select) != Emfoco):
			for nave in $GDNaves.get_children():
				nave.rect_position.x -= 45
		else:
			new_view = true
	if (!Emfoco == ""):
		var get_name = Emfoco.get_slice("nav_",1)
		$TextureRect2/Custo.text = str(Global.allNavs[get_name].custo)
		



func _input(event):
	if event is InputEventScreenDrag:
		var y_Limite_menor = $GDNaves.rect_size.y*1.48
		var y_Limite_maior = $GDNaves.rect_size.y*0.48
		if event.position.y < y_Limite_menor and event.position.y > y_Limite_maior:
			for nave in $GDNaves.get_children():
				nave.rect_position.x += event.relative.x





var index = 0
func insert_navs(nvs):
	for i in nvs:
		var new_name = ('nav_'+i.get_slice(".",0))
		var a = TextureRect.new()
		var path_nav = str("res://grafica/Shopping/navs/"+i)
		var nav_texture:Texture = load(path_nav)
		a.name = new_name
		a.expand = false
		a.stretch_mode = 6
		a.texture = nav_texture
		a.anchor_bottom = 0.817
		a.anchor_left = 0.285
		a.anchor_top = 0.192
		a.anchor_right = 0.718
		a.rect_pivot_offset.x = 156
		a.rect_pivot_offset.y = 186
		a.rect_position.x += 120*index
		index +=1
		$GDNaves.add_child(a)




func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				var _name = String(file_name)
				if _name.find("import") == -1 and _name != ".DS_Store":
					naves_.append(_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")










func operacao(obj, opera, k, eixo):
	var Difereca_PS = 0
	
	if (eixo == "x"):
		if(opera == "-"):
			Difereca_PS = obj.rect_position.x - (obj.texture.get_size().x/2) + k
		elif(opera == "+"):
			Difereca_PS = obj.rect_position.x + (obj.texture.get_size().x/2) - k
	else: 
		if(opera == "-"):
			Difereca_PS =  obj.rect_position.y - (obj.texture.get_size().y/2)
		elif(opera == "+"):
			Difereca_PS =  obj.rect_position.y + (obj.texture.get_size().y/2)
	
	
	return Difereca_PS


func _on_Buy_pressed():
	pass
	


func ordenar():
	var ordem = $GDNaves.get_child_count()
	for nave in $GDNaves.get_children():
		$GDNaves.move_child(nave,ordem)
		ordem -=1




func _on_Voltar_pressed():
	get_tree().change_scene("res://scenes/Inicio.tscn")
