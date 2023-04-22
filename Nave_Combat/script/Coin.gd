extends Area2D

export var balaVel = 100
signal bateu
var bateu = false
export var rodaNormal = 1
var impacto = 0
var desloca = 0
var a = 1.0

func _process(delta):
	if(position.y > 1050 or position.x > 650 or position.x < 40):
		$CoinCollision.set_deferred("disabled", true)
		queue_free()
		
	rotation_degrees += rodaNormal
	if bateu == true:
		if position.x < 490:
			position.x += 3*(3+delta)
		if position.x > 490 and position.y > 27:
			position.x -= 3*(3+delta)
		if position.y > 27:
			position.y -= 3*(3+delta)
		elif position.y <= 27:
			queue_free()
		if position.y > 60 and position.y < 300:
			a -= 0.01
			self.modulate = Color(1, 1, 1, a)
			self.scale.x -= 0.01
			self.scale.y -= 0.01
	elif (Global.Jogo_on == true):
		if Global.go == false:
			if (impacto != 0 and bateu != true):
				position.x += 1*(1+delta)
				position.y += ((balaVel+impacto)*delta)+Global.nave.Coeficiente
			elif bateu != true:
				position.y += ((balaVel+impacto)*delta)+Global.nave.Coeficiente
				rotation_degrees += rodaNormal
		else:
			if position.x < Global.nave["Pos"].x and position.y > Global.nave["Pos"].y:
				position.x += 3*(3+delta)
				position.y -= 3*(3+delta)
			if position.x < Global.nave["Pos"].x and position.y < Global.nave["Pos"].y:
				position.y += 3*(3+delta)
				position.x += 3*(3+delta)
			if position.x > Global.nave["Pos"].x and position.y < Global.nave["Pos"].y:
				position.y += 3*(3+delta)
				position.x -= 3*(3+delta)
			if position.x > Global.nave["Pos"].x and position.y > Global.nave["Pos"].y:
				position.x -= 3*(3+delta)
				position.y -= 3*(3+delta)



func _on_Coin_bateu():
	$AudioStreamPlayer.playing = true
	$CoinCollision.set_deferred("disabled", true)
	Global.dinheiro +=1
	get_parent().emit_signal("coin_anime")
	bateu = true
	


func _on_Coin_area_entered(area):
	if(area.name == "Nave" ):
		emit_signal("bateu")
	else:
		desloca = Global.scaleMeteoro*(128/2)
		rodaNormal += area.rotation_degrees
		impacto = Global.velMeteoro
		


