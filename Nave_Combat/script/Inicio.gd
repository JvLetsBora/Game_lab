extends Control

var anima = ""
var rapido = 0.5
var devagar = 0.1
var normal = 0.25


func _on_Button_pressed():
	anima = "start"

func _process(delta):
	if anima == "start":
		if($Pilares.scale < Vector2(1.5,1.5)):
			$Pilares.scale += Vector2(delta*rapido,delta*rapido)
			$Piso.scale += Vector2(delta*normal,delta*normal)
			$SkayBg.scale += Vector2(delta*devagar,delta*devagar)
			$Shop.modulate -= Color(0, 0, 0, 0.1*normal)
			$Fases.modulate -= Color(0, 0, 0, 0.1*normal)
			$audio.volume_db -= 0.5
		elif($Pilares.scale >= Vector2(1.5,1.5)): 
			get_tree().change_scene("res://scenes/Main.tscn")
	elif anima == "shop":
		if($Pilares.scale < Vector2(1.5,1.5)):
			$Pilares.scale += Vector2(delta*rapido,delta*rapido)
			$Piso.scale += Vector2(delta*normal,delta*normal)
			$SkayBg.scale += Vector2(delta*devagar,delta*devagar)
			$Button.modulate -= Color(0, 0, 0, 0.1*normal)
			$Fases.modulate -= Color(0, 0, 0, 0.1*normal)
			$audio.volume_db -= 0.5
		elif($Pilares.scale >= Vector2(1.5,1.5)): 
			get_tree().change_scene("res://scenes/Shoping.tscn") 

func _on_Fases_pressed():
	pass # Replace with function body.


func _on_Shop_pressed():
	anima = "shop"
