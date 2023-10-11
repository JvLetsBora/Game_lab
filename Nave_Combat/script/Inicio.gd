extends Control


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
	get_tree().change_scene("res://scenes/Main.tscn")



func _on_Fases_pressed():
	pass


func _on_Shop_pressed():
	get_tree().change_scene("res://scenes/Shoping.tscn") 
	
