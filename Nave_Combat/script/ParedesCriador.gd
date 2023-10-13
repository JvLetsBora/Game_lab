extends Node2D

var velocidade = 200
var rng = RandomNumberGenerator.new()
var gira =0
var aceleracao = 1

func _ready():
	position.y = - 140*(1+Global.nave.Coeficiente)
	rng.randomize()
	var my_random_numberE = rng.randf_range(-55,23)
	var my_random_numberD = rng.randf_range(500,625)
	gira = rng.randf_range(0.1,-0.1)
	$AnimationPlayer.get_animation("crash").track_set_key_value(1, 2, Vector2(my_random_numberD,self.position.y+4))
	$AnimationPlayer.get_animation("crash").track_set_key_value(0, 2, Vector2(my_random_numberE,self.position.y+4))
	$AnimationPlayer.play("crash")

	$Colide_D.position.x = my_random_numberD
	$Colide_E.position.x = my_random_numberE






func _process(delta):
	aceleracao += delta
	if(Global.Jogo_on == true):
		position.y += ((velocidade * aceleracao)*delta)*(1+Global.nave.Coeficiente)
		rotation_degrees += gira
	if(position.y > 2200):
		queue_free()


func _on_Colide_D_area_entered(area):
	if(area.name == "Nave"):
		Global.Jogo_on = false
		

func _on_Colide_E_area_entered(area):
	if(area.name == "Nave"):
		Global.Jogo_on = false
		


