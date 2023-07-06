extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#$BG.scale = Vector2()
	a = 0
	modulate = Color(0, 0, 0)

var Emfoco = ""
var a = 0
var dragging = false
var diferenca = 40
var conta = 0
var selecionado = ""
export var borda = 120
var move = false
var precoNave = 200

func _process(delta):
	$SeuGanho.text = "R$"+str(Global.dinheiro)+",00"
	if a >= 0.9 and a <=1:
		modulate = Color(1, 1, 1)
		a = 2
	elif a < 1: 
		modulate += Color(0.1, 0.1, 0.1,0.01)
		a += 0.1
		
	
	for nave in $GD/Naves.get_children():
		if( 490 < operacao(nave,"+",20,"x") and nave.scale.x >= 0.85 or nave.position.x <= 250 and nave.scale.x >= 0.85 ):
			nave.scale -= Vector2(0.005,0.005)
			nave.z_index = 0
			nave.modulate = Color(0.588235, 0.588235, 0.588235)
		elif(nave.scale.x <= 1 and nave.position.x > 251 and nave.position.x < 330):
			nave.scale += Vector2(0.005,0.005)
			nave.z_index = 1
			Emfoco = nave.name
			if nave.name == "Normal":
				$Custo.text = "$0,00 Equipada"
			elif nave.name == "Spectra":
				$Custo.text = "$40,00"
			else:
				$Custo.text = "$80,00"
			nave.modulate = Color(1, 1, 1)
		if nave.position.x >= 445:
			nave.position.x = 165.025
		elif nave.position.x <= 148:
			nave.position.x = 430
		if (nave.z_index == 0 ):
			var zBug = 0
			for t in $GD/Naves.get_children():
				if (t.z_index == 0):
					zBug +=1
			
			if zBug == $GD/Naves.get_children().size() and dragging == false:
				$GD/Naves.get_children()[zBug-1].position = Vector2((get_viewport().size.x/2),((get_viewport().size.y/2)-($GD/Naves/Normal.texture.get_size().y/4)))
				$GD/Naves.get_children()[zBug-1].scale = Vector2(1,1)
				$GD/Naves.get_children()[zBug-1].z_index = 1
				$GD/Naves.get_children()[zBug-1].modulate = Color(1, 1, 1)
				selecionado = $GD/Naves.get_children()[zBug-1].name
				zBug = 0
				
	

func _input(event):
	
	if event is InputEventScreenTouch and event.is_pressed():
		if (event.position.x > operacao($GD/Naves/Normal,"-",20,"x") and event.position.x < operacao($GD/Naves/Normal,"+",20,"x") and event.position.y > operacao($GD/Naves/Normal,"-",0,"y") and event.position.y < operacao($GD/Naves/Normal,"+",0,"y") and $GD/Naves/Normal.z_index == 1):
			conta = event.position.x - $GD/Naves/Normal.position.x
			selecionado = "Normal"
			dragging = event.is_pressed()
			
			
		elif(event.position.x > operacao($GD/Naves/Spectra,"-",20,"x") and event.position.x < operacao($GD/Naves/Spectra,"+",20,"x") and event.position.y > operacao($GD/Naves/Spectra,"-",0,"y") and event.position.y < operacao($GD/Naves/Spectra,"+",0,"y") and $GD/Naves/Spectra.z_index == 1 ):
			conta = event.position.x - $GD/Naves/Spectra.position.x
			selecionado = "Spectra"
			dragging = event.is_pressed()
			
			
		elif(event.position.x > operacao($GD/Naves/Obsidian,"-",20,"x") and event.position.x < operacao($GD/Naves/Obsidian,"+",20,"x") and event.position.y > operacao($GD/Naves/Obsidian,"-",0,"y") and event.position.y < operacao($GD/Naves/Obsidian,"+",0,"y") and $GD/Naves/Obsidian.z_index == 1 ):
			conta = event.position.x - $GD/Naves/Obsidian.position.x
			selecionado = "placeholder"
			dragging = event.is_pressed()
			
			
		
	elif event is InputEventScreenTouch and not event.is_pressed(): dragging = event.is_pressed()

	if event is InputEventMouseMotion and dragging:
		# While dragging, move the sprite with the mouse.
		if selecionado == "Spectra" and $GD/Naves/Spectra.position.x + ($GD/Naves/Spectra.texture.get_size().x/2) < 586:
			$GD/Naves/Spectra.position.x = event.position.x - conta
			$GD/Naves/Normal.position.x = event.position.x - conta + borda
			$GD/Naves/Obsidian.position.x = event.position.x - conta - borda
			
		elif  selecionado == "Normal" and $GD/Naves/Normal.position.x + ($GD/Naves/Normal.texture.get_size().x/2) < 586:
			$GD/Naves/Normal.position.x = event.position.x - conta
			$GD/Naves/Spectra.position.x = event.position.x - conta - borda
			$GD/Naves/Obsidian.position.x = event.position.x - conta + borda
			
			
		elif  selecionado == "placeholder"  and $GD/Naves/Obsidian.position.x + ($GD/Naves/Obsidian.texture.get_size().x/2) < 586: 
			$GD/Naves/Obsidian.position.x = event.position.x - conta
			$GD/Naves/Spectra.position.x = event.position.x - conta + borda
			$GD/Naves/Normal.position.x = event.position.x - conta - borda
			
		


func operacao(obj, opera, k, eixo):
	var Difereca_PS = 0
	
	if (eixo == "x"):
		if(opera == "-"):
			Difereca_PS = obj.position.x - (obj.texture.get_size().x/2) + k
		elif(opera == "+"):
			Difereca_PS = obj.position.x + (obj.texture.get_size().x/2) - k
	else: 
		if(opera == "-"):
			Difereca_PS =  obj.position.y - (obj.texture.get_size().y/2)
		elif(opera == "+"):
			Difereca_PS =  obj.position.y + (obj.texture.get_size().y/2)
	
	
	return Difereca_PS

func _on_Voltar_released():
	get_tree().change_scene("res://scenes/Inicio.tscn")


func _on_Buy_pressed():
	if Emfoco == "Normal":
		precoNave = 0
	elif Emfoco == "Spectra":
		precoNave = 40
	else:
		precoNave = 80
	if selecionado == "":
		Emfoco = "Normal"
	else:
		if Global.dinheiro >= precoNave:
			Global.dinheiro -= precoNave
			Global.Nav_select = Emfoco
			print("Saldo: ",Global.dinheiro," Nav: ",Global.Nav_select)
		else: print("Sem grana")
		

	
