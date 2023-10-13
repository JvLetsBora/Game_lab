extends Control


var rapido = 0.5
var devagar = 0.1
var normal = 0.25
var rng = RandomNumberGenerator.new()

func _ready():
	
	rect_size.x = get_viewport().size.x
	rect_size.y = get_viewport().size.y
	#$back_3.rect_position = Vector2((get_viewport().size.x/2),(get_viewport().size.y/2))
	#$back_2.rect_position = Vector2((get_viewport().size.x/2),(get_viewport().size.y/2))
	#$back_1.rect_position = Vector2((get_viewport().size.x/2),(get_viewport().size.y/2))


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")

func _process(delta):
		$back_1/ParallaxBackground/primeiro.motion_offset.y += (150*delta)*0.1
		$back_1/ParallaxBackground/quarto.motion_offset.y += (150*delta)*0.4
		$back_1/ParallaxBackground/segundo.motion_offset.y += (150*delta)*2

func _on_Fases_pressed():
	rng.randomize()
	var rand = rng.randf_range(0.0, 1.0)
	var rand2 = rng.randf_range(0.0, 1.0)
	var rand3 = rng.randf_range(0.0, 1.0)

	
	$Fases.modulate = Color(rand,rand2, rand3)


func _on_Shop_pressed():
	get_tree().change_scene("res://scenes/Shoping.tscn") 
	
