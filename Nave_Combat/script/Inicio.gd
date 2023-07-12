extends Control

var anima = ""
var rapido = 0.5
var devagar = 0.1
var normal = 0.25


func _ready():
	rect_size.x = get_viewport().size.x
	rect_size.y = get_viewport().size.y
	#$back_3.rect_position = Vector2((get_viewport().size.x/2),(get_viewport().size.y/2))
	#$back_2.rect_position = Vector2((get_viewport().size.x/2),(get_viewport().size.y/2))
	#$back_1.rect_position = Vector2((get_viewport().size.x/2),(get_viewport().size.y/2))


func _on_Button_pressed():
	anima = "start"

func _process(delta):

	if anima == "start":
		if($back_3.rect_size < Vector2(1.5,1.5)):
			$back_3.rect_size += Vector2(delta*rapido,delta*rapido)
			$back_2.rect_size += Vector2(delta*normal,delta*normal)
			$back_1.rect_size += Vector2(delta*devagar,delta*devagar)
			$Shop.modulate -= Color(0, 0, 0, 0.1*normal)
			$Fases.modulate -= Color(0, 0, 0, 0.1*normal)
			$audio.volume_db -= 0.5
		elif($back_3.rect_size >= Vector2(1.5,1.5)): 
			get_tree().change_scene("res://scenes/Main.tscn")
	elif anima == "shop":
		if($back_3.rect_size < Vector2(1.5,1.5)):
			$back_3.rect_size += Vector2(delta*rapido,delta*rapido)
			$back_2.rect_size += Vector2(delta*normal,delta*normal)
			$back_1.rect_size += Vector2(delta*devagar,delta*devagar)
			$Button.modulate -= Color(0, 0, 0, 0.1*normal)
			$Fases.modulate -= Color(0, 0, 0, 0.1*normal)
			$audio.volume_db -= 0.5
		elif($back_3.rect_size >= Vector2(1.5,1.5)): 
			get_tree().change_scene("res://scenes/Shoping.tscn") 

func _on_Fases_pressed():
	pass # Replace with function body.


func _on_Shop_pressed():
	anima = "shop"
